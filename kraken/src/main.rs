extern crate actix_web;
use actix_web::{get, post, web, App, HttpRequest, HttpResponse, HttpServer, Responder};

#[get("/heartbeat")]
async fn heartbeat() -> impl Responder {
    HttpResponse::Ok().body("Kraken is alive!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(heartbeat))
        .bind("0.0.0.0:6007")?
        .run()
        .await
}

// WISHLIST
// API endpoints using actix-web
// TCP socket stuff, need to split 1 socket for into 2+ parallel read/write pipes
// ORM stuff : want to store and retrieve data from postgres using diesel
