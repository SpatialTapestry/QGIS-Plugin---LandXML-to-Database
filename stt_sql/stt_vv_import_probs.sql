-- Table: xxSchemaxx.stt_vv_import_probs

-- DROP TABLE IF EXISTS xxSchemaxx.stt_vv_import_probs;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_vv_import_probs
(
    gid SERIAL NOT NULL,
    srcpntno integer NOT NULL,
    dstpntno integer NOT NULL,
    geom_orig geometry(LineString,xxxx)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_vv_import_probs
    OWNER to rogermsu;
