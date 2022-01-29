const {
    minimal,
    common,
    ardupilotmega,
    uavionix,
    icarous,
    MavLinkPacketSplitter,
    MavLinkPacketParser,
    MavLinkProtocolV2,
    send
} = require('node-mavlink');

const { connect } = require('net');
const SerialPort = require('serialport');
const fs = require('fs');
const express = require('express');
const http = require('http')
const app = express();

app.listen(6002, () => {
    console.log("Listening on port 3000")
})

// create a registry of mappings between a message id and a data class
const REGISTRY = {
    ...minimal.REGISTRY,
    ...common.REGISTRY,
    ...ardupilotmega.REGISTRY,
    ...uavionix.REGISTRY,
    ...icarous.REGISTRY,
}

const port = connect({ host: 'localhost', port: 5769 }) //SITL or other network source
// const port = new SerialPort('/dev/tty.usbmodem14401') //serial port

//maybe add this for extra coolness https://github.com/padcom/node-mavlink#signed-packages

// const msg = new common.CommandInt()
// // msg.command = common.MavCmd.SET_MESSAGE_INTERVAL //pressure
// // msg.param1 = 28
// // msg.param2 = 1000
// // msg.param3 = 0

const TELEMETRY = {}

const beginReadingMav = () => {
    const reader = port
        .pipe(new MavLinkPacketSplitter())
        .pipe(new MavLinkPacketParser())

    port.on('open', async () => {
        // the port is open - we're ready to send data
        // await send(port, msg, new MavLinkProtocolV2())
        console.log("connected")
    })

    reader.on('data', packet => {
        const data_class = REGISTRY[packet.header.msgid]
        if (data_class) {
            const data = packet.protocol.data(packet.payload, data_class);
            console.log(data);

            // if( !TELEMETRY[data.constructor.name] ){
            //     TELEMETRY[data.constructor.name] = {}
            // }

            // for(let entry of Object.entries(data)){
            //     TELEMETRY[data.constructor.name][entry[0]] = entry[1]
            // }
        }
    })
}


// https://github.com/GoogleChromeLabs/jsbi/issues/30
// Receiving end will also need to do this... or we just ban bigints...
const SAFE_JSON_STRINGIFY = (obj) => {
    return JSON.stringify(obj, (key, value) => {
        if (typeof value === 'bigint') {
            return value.toString();
        } else {
            return value;
        }
    })
}

// setInterval(() => {
//     fs.writeFileSync("./all_telem.json", BIGINT_SAFE_JSON(TELEMETRY), (err) => {
//         if(err){
//             console.log(err)
//         }
//     })
//     console.log("Telemetry updated")
// }, 1000)




/**
 * Sends current telemetry to GCOM
 */
const postTelemetryToGCOM = () => {

    try {
        let sim_data = {
            latitude_dege7: TELEMETRY.GlobalPositionInt.lat,
            longitude_dege7: TELEMETRY.GlobalPositionInt.lon,
            altitude_msl_m: TELEMETRY.GlobalPositionInt.alt / 100,
            heading_deg: TELEMETRY.GlobalPositionInt.hdg / 100
        }
        let sim_string = SAFE_JSON_STRINGIFY(sim_data)

        let options = {
            hostname: '127.0.0.1',
            port: 8080,
            path: '/api/interop/telemetry',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': sim_string.length
            }
        }
        let gcom_hotfix_request = http.request(options, res => {
            switch (res.statusCode) {
                case 200:
                    console.log("TELEM POST to GCOM-X [OK]")
                    break;
                default:
                    console.log(`TELEM POST to GCOM-X [FAILED]: code ${res.statusCode}`)
            }
        })

        gcom_hotfix_request.write(sim_string)

        gcom_hotfix_request.on('error', (err) => {
            console.error(`Error while connecting to GCOM-X: ${err.message}`);
        });

        gcom_hotfix_request.end()
    } catch (err) {
        // console.error(err)

    }
}

const getTelemetryFromACOM = () => {
    try {
        http.request({
            hostname: '127.0.0.1',
            port: 5000,
            path: '/aircraft/telemetry/gps',
            method: 'GET',
            json: true
        }, res => {
            res.setEncoding('utf8');
            switch (res.statusCode) {
                case 200:
                    console.log("TELEM GET from ACOM [OK]");
                    res.on('data', acomTelemetryString => {
                        let acomTelemetry = JSON.parse(acomTelemetryString);
                        TELEMETRY.GlobalPositionInt = {
                            lat: acomTelemetry.lat * 10 ** 7,
                            lon: acomTelemetry.lng * 10 ** 7,
                            alt: acomTelemetry.alt * 100,
                            hdg: acomTelemetry.heading * 100
                        }
                    });
                    break;
                default:
                    console.log(`TELEM GET from ACOM [FAILED]: code ${res.statusCode}`);
            }
        }).on('error', (err) => {
            console.error(`Error while fetching telemetry from ACOM: ${err.message}`);
        }).end();
    } catch (err) {
        console.log(`Error during GET ACOM telemetry: ${err}`)
    }
}

setInterval(getTelemetryFromACOM, 1000)
setInterval(postTelemetryToGCOM, 1000)

app.get('/', (req, res) => {
    let scope = req.query.scope
    if (!scope) {
        res.send(SAFE_JSON_STRINGIFY(TELEMETRY))
    } else {
        try {
            let scopes = scope.split('.')
            let scopedData = scopes.slice(0, -1).reduce((scoped_obj, key) => scoped_obj[key], TELEMETRY)[scopes.pop()];
            res.send(SAFE_JSON_STRINGIFY(scopedData))
        } catch (err) {
            res.send("oopsie daisie")
        }
    }
})
