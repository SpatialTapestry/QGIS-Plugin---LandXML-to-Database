-- Table: xxSchemaxx.stt_vectorvector

-- DROP TABLE IF EXISTS xxSchemaxx.stt_vectorvector;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_vectorvector
(
    gid SERIAL NOT NULL,
    isvalidated boolean NOT NULL DEFAULT false,
    blockid integer,
    srcpntno integer NOT NULL,
    geom_pnt_src geometry(Point,xxxx),
    dstpntno integer NOT NULL,
    geom_pnt_dst geometry(Point,xxxx),
    geom_dwn geometry(LineString,xxxx),
    geom_pnt_dwn geometry(Point,xxxx),
    geom_proj geometry(Point,7855),
    length real NOT NULL,
    scoretag character varying(10) COLLATE pg_catalog."default",
    scoreval real,
    geom_orig geometry(LineString,xxxx),
    diffx real DEFAULT 0,
    diffy real DEFAULT 0,
    stddevx real DEFAULT 0,
    stddevy real DEFAULT 0,
    probprob boolean DEFAULT false,
    topoonly boolean DEFAULT false,
    avediffx real DEFAULT 0,
    avediffy real DEFAULT 0,
    geom_prop geometry(Geometry,xxxx),
    CONSTRAINT gidpvvjkey PRIMARY KEY (gid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_vectorvector
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_vectorvector
    IS 'This table is where the shift vectors are stored in the Shift Cadastre work flow, when the current (source) landbase and spatially dependent layers (road centre lines, suburbs, annotation, etc) need to be moved to fit a new (destination) landbase';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.isvalidated
    IS 'Future software may record if the shift vector has been checked by a human';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.blockid
    IS 'The Temporary Work Area Block Id the shift vector is in';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.srcpntno
    IS 'The point number in public.stt_point that the shift vector begins with';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.geom_pnt_src
    IS 'The point geometry of the source point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.dstpntno
    IS 'The point number in dest_landbase.stt_point that the shift vector begins with';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.geom_pnt_dst
    IS 'The point geometry of the destination point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.length
    IS 'The length in metres of the shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.scoretag
    IS 'The name of the routine that generated the shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.scoreval
    IS 'The score assigned to the shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.geom_orig
    IS 'The linestring geometry from the source point to the destination point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorvector.probprob
    IS 'True if the shift vector is probably a problem, these should be checked by an operator and fixed if necessary';
-- Index: xxSchemaxx_idx_stt_l_sv_vv

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_l_sv_vv;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_l_sv_vv
    ON xxSchemaxx.stt_vectorvector USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_pd_sv_vv

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_pd_sv_vv;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_pd_sv_vv
    ON xxSchemaxx.stt_vectorvector USING gist
    (geom_pnt_dst)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_ps_sv_vv

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_ps_sv_vv;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_ps_sv_vv
    ON xxSchemaxx.stt_vectorvector USING gist
    (geom_pnt_src)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_v_sv_proj

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_v_sv_proj;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_v_sv_proj
    ON xxSchemaxx.stt_vectorvector USING gist
    (geom_proj)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_v_sv_vv

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_v_sv_vv;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_v_sv_vv
    ON xxSchemaxx.stt_vectorvector USING btree
    (scoreval ASC NULLS LAST)
    TABLESPACE pg_default;


