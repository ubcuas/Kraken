pub enum UASTelemetryKey {
    GPS_POSITION,
    SPEED,
    ALTITUDE_MSL
    RUNTIME,
    VIBRATION,
    BATTERY_CAPACITY,
    BATTERY_VOLTAGE,
    HEADING,
    TEMPERATURE,
    STORAGE,
    NETWORK_SPEED,
    GENERIC,
}

/* DEFINITIONS */
#[derive(Queryable)]
pub struct UASTelemetry {
    pub telemetryKey: UASTelemetryKey;
    pub unit: String;
    pub value: String;
    pub timestamp: DateTime,
}
