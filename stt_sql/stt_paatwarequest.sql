-- Table: xxSchemaxx.stt_paatwarequest

-- DROP TABLE IF EXISTS xxSchemaxx.stt_paatwarequest;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_paatwarequest
(
    paatwacsbdpdesc character varying(4) COLLATE pg_catalog."default",
    paatwacsbdpnumber character varying(128) COLLATE pg_catalog."default",
    assignedseq integer,
    approach2use integer,
    processdesc character varying(128) COLLATE pg_catalog."default",
    operator character varying(128) COLLATE pg_catalog."default",
    date_added timestamp(0) without time zone,
    geom_orig geometry(MultiPolygon,xxxx),
    geom_prop geometry(Geometry,xxxx)
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_paatwarequest
    OWNER to rogermsu;

GRANT ALL ON TABLE xxSchemaxx.stt_paatwarequest TO rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_paatwarequest
    IS 'This table records every rest call';

COMMENT ON COLUMN xxSchemaxx.stt_paatwarequest.paatwacsbdpdesc
    IS 'This field records the Area Type the rest call acts on, DP, CSB, TWA, PAA or NA';
-- Index: xxSchemaxx_idx_stt_paatwareq_o

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_paatwareq_o;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_paatwareq_o
    ON xxSchemaxx.stt_paatwarequest USING gist
    (geom_orig)
    TABLESPACE pg_default;