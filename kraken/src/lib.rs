#[macro_use]
extern crate dotenv_codegen;
use postgres::{Client, Error, NoTls};
use serde::Serialize;

#[derive(Serialize)]
pub struct Telemetry {
    pub id: i32,
    pub key: String,
    pub value: String,
    pub unit: String,
    pub timestamp: std::time::SystemTime,
}

// TODO: add some serious error handling in here :^) or don't ...
pub fn connect_to_postgres() -> postgres::Client {
    let conn_string: &str = &format!(
        "postgresql://{}:{}@localhost:{}/{}",
        dotenv!("KRAKEN_DB_USER"),
        dotenv!("KRAKEN_DB_USER_PASSWORD"),
        dotenv!("POSTGRES_PORT"),
        dotenv!("KRAKEN_DB")
    )[..];

    let client = Client::connect(conn_string, NoTls).unwrap();

    return client;
}
