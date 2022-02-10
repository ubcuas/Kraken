# See https://www.lpalmieri.com/posts/fast-rust-docker-builds/

# TODO: Replace this with a UAS cargo-chef + rust image
FROM lukemathwalker/cargo-chef:latest-rust-1.53.0 AS chef
WORKDIR /kraken

FROM chef AS planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder
COPY --from=planner /kraken/recipe.json recipe.json
# Build dependencies - this is the caching Docker layer!
RUN cargo chef cook --release --recipe-path recipe.json
# Build krakenlication
COPY . .
RUN cargo build --release --bin kraken

# We do not need the Rust toolchain to run the binary!
FROM debian:bullseye-slim AS runtime
WORKDIR /kraken
COPY --from=builder /kraken/target/release/kraken /usr/local/bin

EXPOSE 6007
ENTRYPOINT ["/usr/local/bin/kraken"]