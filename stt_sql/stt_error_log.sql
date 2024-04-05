-- Table: xxSchemaxx.stt_error_log

-- DROP TABLE IF EXISTS xxSchemaxx.stt_error_log;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_error_log
(
    theme_name character varying(512) COLLATE pg_catalog."default",
    theme_fid character varying(64) COLLATE pg_catalog."default",
    routine_name character varying(512) COLLATE pg_catalog."default",
    error character varying(512) COLLATE pg_catalog."default",
    err_date timestamp(0) without time zone,
    geom geometry(Geometry,xxxx)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_error_log
    OWNER to rogermsu;