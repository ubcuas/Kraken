use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder};
use kraken::greet;

fn main() {
    greet();
}

// WISHLIST
// API endpoints using actix-web
// TCP socket stuff, need to split 1 socket for into 2+ parallel read/write pipes
// ORM stuff : want to store and retrieve data from postgres using diesel
