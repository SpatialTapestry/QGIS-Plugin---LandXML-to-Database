-- Table: xxSchemaxx.stt_twa_xover

-- DROP TABLE IF EXISTS xxSchemaxx.stt_twa_xover;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_twa_xover
(
    gid SERIAL NOT NULL,
    destpntno integer,
    srcepntno integer,
    geom_orig geometry(LineString,xxxx),
    length real NOT NULL,
    created date,
    twablockid integer,
    username character varying(64) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_twa_xover
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_twa_xover
    IS 'This table is used to manage those Shift Vectors that cross from one TWA to another TWA to ensure there is not a double shift when the adjoining TWA is moved. This will explain with diagrams in a System Manual at a later time';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.destpntno
    IS 'The point number in the destination stt_point table';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.srcepntno
    IS 'The point number in the source stt_point table';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.geom_orig
    IS 'The linestring geometry from the source point to the destination point';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.length
    IS 'The length in metres of the shift Vector';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.created
    IS 'The date and time this shift vector was created';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.twablockid
    IS 'The TWA block Id that this shift vector originated from';

COMMENT ON COLUMN xxSchemaxx.stt_twa_xover.username
    IS 'The username of the person running the TWA Upgrade when this shift vector was created';
