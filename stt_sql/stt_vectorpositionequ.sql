-- Table: xxSchemaxx.stt_vectorpositionequ

-- DROP TABLE IF EXISTS xxSchemaxx.stt_vectorpositionequ;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_vectorpositionequ
(
    gid SERIAL NOT NULL,
    controlpoint SERIAL NOT NULL,
    geom_ctrl geometry(Point,xxxx),
    adjustpoint integer NOT NULL,
    geom_srce geometry(Point,xxxx),
    geom_orig geometry(LineString,xxxx),
    posnequstdm real NOT NULL,
    projsrid integer,
    blockid integer,
    geom_mast geometry(Geometry,xxxx),
    geom_adj geometry(Point,xxxx),
    geom_dwn geometry(Point,xxxx),
    geom_prop geometry(Geometry,xxxx),
    CONSTRAINT stt_vectorpositionequs_adjustpoint_key UNIQUE (adjustpoint)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_vectorpositionequ
    OWNER to rogermsu;

COMMENT ON COLUMN xxSchemaxx.stt_vectorpositionequ.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_vectorpositionequ.controlpoint
    IS ' A System generated unique record UID';
-- Index: xxSchemaxx_idx_stt_vpe_a

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_vpe_a;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_vpe_a
    ON xxSchemaxx.stt_vectorpositionequ USING gist
    (geom_adj)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_vpe_c

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_vpe_c;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_vpe_c
    ON xxSchemaxx.stt_vectorpositionequ USING gist
    (geom_ctrl)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_stt_vpe_ano

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_vpe_ano;

CREATE UNIQUE INDEX IF NOT EXISTS xxSchemaxx_stt_vpe_ano
    ON xxSchemaxx.stt_vectorpositionequ USING btree
    (adjustpoint ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_stt_vpe_cno

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_vpe_cno;

CREATE UNIQUE INDEX IF NOT EXISTS xxSchemaxx_stt_vpe_cno
    ON xxSchemaxx.stt_vectorpositionequ USING btree
    (controlpoint ASC NULLS LAST)
    TABLESPACE pg_default;
