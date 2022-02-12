Run
`cargo install diesel_cli`
to get the package necessary to interact with the ORM engine.

Don't add this to cargo.toml; it has no purpose in production.


Use `make lint` in the kraken/Makefile to check for linting issues before committing your code.

*WISHLIST*

- API endpoints using actix-web
- TCP socket stuff, need to split 1 socket for into 2+ parallel read/write pipes
- ORM stuff : want to store and retrieve data from postgres using diesel

# **Kraken**
### **What is Kraken?**
Kraken is responsible for the following in the UAS software ecosystem:
- Universal Logging
- Telemetry Aggregation
- Proxy between GCS and aircraft for imagery, telemetry and controls

### **How to start Kraken**
```
docker-compose up
```
TODO: insert other instructions here for diesel setup

### **Available Endpoints**
Full endpoint documentation is available in the [Kraken Postman Workspace](https://www.postman.com/ubcuas/workspace/uas-kraken)


**Maintainers**
- Alexander Chudinov
- Nazare Neal
- Stanley Zhao
