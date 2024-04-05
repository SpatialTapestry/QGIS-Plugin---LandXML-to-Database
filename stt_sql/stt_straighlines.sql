-- Table: xxSchemaxx.stt_straighlines

-- DROP TABLE IF EXISTS xxSchemaxx.stt_straighlines;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_straighlines
(
    anumber integer,
    geom_orig geometry(LineString,xxxx)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_straighlines
    OWNER to rogermsu;
-- Index: xxSchemaxx_idx_stt_straightlines

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_straightlines;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_straightlines
    ON xxSchemaxx.stt_straighlines USING gist
    (geom_orig)
    TABLESPACE pg_default;