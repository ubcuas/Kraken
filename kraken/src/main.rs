use actix_web::{get, post, web, App, HttpRequest, HttpResponse, HttpServer, Responder};
use dotenv::dotenv;
use json::{object, stringify};

// [FOR WEB ENDPOINTS] PORT THAT KRAKEN LISTENS ON
const KRAKEN_PORT: i32 = 6007;

#[get("/heartbeat")]
async fn heartbeat() -> impl Responder {
    HttpResponse::Ok().body("Kraken is alive!")
}

//TODO: way more endpoints to write

#[get("/telemetry")]
async fn telemetry() -> impl Responder {
    let placeholder_telemetry = object! {
        latitude_dege7: 150000,
        longitude_dege7: 60000,
        altitude_msl_m: 15.34,
        heading_deg: 234.32
    };
    HttpResponse::Ok().body(stringify(placeholder_telemetry))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();

    HttpServer::new(|| App::new().service(heartbeat).service(telemetry))
        .bind(format!("0.0.0.0:{}", KRAKEN_PORT))?
        .run()
        .await
}
