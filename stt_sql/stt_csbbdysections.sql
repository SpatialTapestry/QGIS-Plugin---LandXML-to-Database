-- Table: xxSchemaxx.stt_csbbdysections

-- DROP TABLE IF EXISTS xxSchemaxx.stt_csbbdysections;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_csbbdysections
(
    blockid integer,
    csbid integer,
    tag character varying(20) COLLATE pg_catalog."default",
    geom_sctn geometry(LineString,xxxx),
    geom_svs geometry(MultiLineString,xxxx),
    geom_v geometry(MultiLineString,xxxx),
    gid SERIAL NOT NULL,
    begpntr integer,
    endpntr integer,
    numsctpnts integer,
    mindefnd real,
    maxdefnd real,
    avedefnd real,
    mindefnleftd real,
    maxdefnleftd real,
    avedefnleftd real,
    mindefnrightd real,
    maxdefnrightd real,
    avedefnrightd real,
    tltdistalong real,
    mindistalong real,
    maxdistalong real,
    avedistalong real,
    arccenteast double precision,
    arccentnrth double precision,
    radius real,
    numsv integer,
    numleftsv integer,
    numrightsv integer,
    mindifflen real,
    maxdifflen real,
    avedifflen real,
    svmindist real,
    svmaxdist real,
    svavedist real,
    svstddev real,
    numprobs integer,
    numtopo integer,
    numvgeom integer,
    isriparian boolean,
    euclidist real,
    mbrdist real,
    isclosesection boolean,
    num90degleft integer,
    num45degleft integer,
    num45degright integer,
    num90degright integer
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_csbbdysections
    OWNER to rogermsu;
-- Index: xxSchemaxx_stt_csbbdysects

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_csbbdysects;

CREATE INDEX IF NOT EXISTS xxSchemaxx_stt_csbbdysects
    ON xxSchemaxx.stt_csbbdysections USING btree
    (begpntr ASC NULLS LAST)
    TABLESPACE pg_default;
