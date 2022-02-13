#[macro_use]
extern crate dotenv_codegen;

use actix_web::{get, post, web, App, HttpRequest, HttpResponse, HttpServer, Responder};
use dotenv::dotenv;
use kraken;
use serde_json;

// [FOR WEB ENDPOINTS] PORT THAT KRAKEN LISTENS ON
const KRAKEN_PORT: &str = dotenv!("KRAKEN_PORT");

#[get("/heartbeat")]
async fn heartbeat_endpoint() -> impl Responder {
    HttpResponse::Ok().body("Kraken is alive!")
}

//TODO: way more endpoints to write

#[get("/telemetry")]
async fn telemetry_endpoint() -> impl Responder {
    HttpResponse::Ok().body(serde_json::to_string(&get_all_telemetry()).unwrap())
}

pub fn get_all_telemetry() -> Vec<kraken::Telemetry> {
    let mut conn: postgres::Client = kraken::connect_to_postgres();
    let mut telemetry_vec = vec![];

    for row in &conn.query("SELECT * FROM telemetry", &[]).unwrap() {
        telemetry_vec.push(kraken::Telemetry {
            id: row.get(0),
            key: row.get(1),
            value: row.get(2),
            unit: row.get(3),
            timestamp: row.get(4),
        });
    }

    return telemetry_vec;
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();

    for t in get_all_telemetry() {
        println!("TELEMETRY {}: {} - {}{}", t.id, t.key, t.value, t.unit);
    }

    HttpServer::new(|| {
        App::new()
            .service(heartbeat_endpoint)
            .service(telemetry_endpoint)
    })
    .bind(format!("0.0.0.0:{}", KRAKEN_PORT))?
    .run()
    .await
}
