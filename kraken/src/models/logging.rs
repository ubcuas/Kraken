enum UniversalLogOrigin {
    GCOM,
    ACOM,
    KRAKEN,
    STALKER,
    SKYPASTA,
    SUNFLOWER,
    ACTIVE_AIRCRAFT_AVOIDANCE,
    VULCAN,
    UNKNOWN,
}

enum UniversalLogType {
    ERROR,
    WARNING,
    INFO,
    SUCCESS,
    UNKNOWN,
}

#[derive(Queryable)]
pub struct UASUniversalLog {
    origin: UniversalLogOrigin;
    log_type: UniversalLogType;
    content: String;
    timestamp: DateTime;
}
