-- Table: xxSchemaxx.stt_probfeats

-- DROP TABLE IF EXISTS xxSchemaxx.stt_probfeats;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_probfeats
(
    gid SERIAL NOT NULL,
    themename character varying(400) COLLATE pg_catalog."default",
    feadureid character varying(200) COLLATE pg_catalog."default",
    geom_orig geometry(Geometry,xxxx),
    geom_adj geometry(Geometry,xxxx)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_probfeats
    OWNER to rogermsu;
