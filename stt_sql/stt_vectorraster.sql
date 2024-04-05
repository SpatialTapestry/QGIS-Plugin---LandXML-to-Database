-- Table: xxSchemaxx.stt_vectorraster

-- DROP TABLE IF EXISTS xxSchemaxx.stt_vectorraster;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_vectorraster
(
    gid SERIAL NOT NULL,
    controlpoint SERIAL NOT NULL,
    geom_ctrl geometry(Point,xxxx),
    adjustpoint integer NOT NULL,
    geom_srce geometry(Point,xxxx),
    scoretag character varying(10) COLLATE pg_catalog."default",
    projsrid integer,
    blockid integer,
    geom_orig geometry(LineString,xxxx),
    geom_adj geometry(Point,xxxx),
    geom_dwn geometry(Point,xxxx),
    CONSTRAINT stt_vectorraster_adjustpoint_key UNIQUE (adjustpoint)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_vectorraster
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_vectorraster
    IS 'This table records shift vectors between points in the landbase, road centrelines, waterways, power poles, buildings, etc, to points in the raster/orthophotography';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.controlpoint
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.geom_ctrl
    IS 'The point geometry of the control point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.adjustpoint
    IS 'The point number in public.stt_point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.geom_srce
    IS 'The point geometry of the vector point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.projsrid
    IS 'The SRID the shift vector was collected in';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.blockid
    IS 'The TWA Block Number the point is in';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.geom_orig
    IS 'The linestring geometry from the point to the raster location';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.geom_adj
    IS 'The adjusted linestring geometry post LSA or IBG upgrade';

COMMENT ON COLUMN xxSchemaxx.stt_vectorraster.geom_dwn
    IS 'The downgraded geometry post fti2Fabric';
-- Index: xxSchemaxx_idx_stt_vrs_a

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_vectrast_a;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_vectrast_a
    ON xxSchemaxx.stt_vectorraster USING gist
    (geom_adj)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_vrs_c

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_vectrast_c;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_vectrast_c
    ON xxSchemaxx.stt_vectorraster USING gist
    (geom_ctrl)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_vrs_orig

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_vectrast_orig;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_vectrast_orig
    ON xxSchemaxx.stt_vectorraster USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_stt_vrs_ano

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_vectrast_ano;

CREATE UNIQUE INDEX IF NOT EXISTS xxSchemaxx_stt_vectrast_ano
    ON xxSchemaxx.stt_vectorraster USING btree
    (adjustpoint ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_stt_vrs_cno

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_vectrast_cno;

CREATE UNIQUE INDEX IF NOT EXISTS xxSchemaxx_stt_vectrast_cno
    ON xxSchemaxx.stt_vectorraster USING btree
    (controlpoint ASC NULLS LAST)
    TABLESPACE pg_default;
