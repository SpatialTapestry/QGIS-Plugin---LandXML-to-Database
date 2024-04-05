-- Table: xxSchemaxx.dest_point

-- DROP TABLE IF EXISTS xxSchemaxx.dest_point;

CREATE TABLE IF NOT EXISTS xxSchemaxx.dest_point
(
    gid SERIAL NOT NULL,
    pointno integer,
    blockid integer,
    jobid integer,
    paa_id integer,
    nodetype character varying(10) COLLATE pg_catalog."default",
    adj_status character varying(7) COLLATE pg_catalog."default",
    onanarc boolean,
    arcbeg boolean,
    arcend boolean,
    pntradius real,
    geom_orig geometry(Point,xxxx),
    srce_lyr character varying(50) COLLATE pg_catalog."default",
    have_shiftvector boolean DEFAULT false,
    parcelcount integer,
    oncsbbdy boolean DEFAULT false,
    incsbbdy boolean DEFAULT false,
    outcsbbdy boolean DEFAULT true,
    dist2sv real DEFAULT 1000,
    dist2csb real DEFAULT 1000,
    geom_proj geometry(Point,7855),
    csbbdydeflangd real DEFAULT '-1001'::integer,
    CONSTRAINT giddestdcadpntpkey PRIMARY KEY (gid)
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.dest_point
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.dest_point
    IS 'This table is populated from public.stt_point, it contains extra fields to help with various work flows.';

COMMENT ON COLUMN xxSchemaxx.dest_point.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.dest_point.pointno
    IS 'A Point Number for each point record, sourced from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.dest_point.blockid
    IS 'The Temporary Work Area the point is in, sourced from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.dest_point.jobid
    IS 'The Job Id of the workflow which caused the point record to be copied from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.dest_point.paa_id
    IS 'The Plan Adjustment Area Id the point is in, sourced from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.dest_point.nodetype
    IS 'Used in the software for various processes, including Shift Vector generation';

COMMENT ON COLUMN xxSchemaxx.dest_point.adj_status
    IS 'The adjustment status';

COMMENT ON COLUMN xxSchemaxx.dest_point.onanarc
    IS 'True if the software detects anc arc, such as a cal de sac';

COMMENT ON COLUMN xxSchemaxx.dest_point.geom_orig
    IS 'The point geometry for the original coordinates';

COMMENT ON COLUMN xxSchemaxx.dest_point.srce_lyr
    IS 'The layer that the point was first found in, usually the landbase, but also road centre lines, suburbs, mesh blocks, etc';

COMMENT ON COLUMN xxSchemaxx.dest_point.have_shiftvector
    IS 'True if the point has been given a shift vector';

COMMENT ON COLUMN xxSchemaxx.dest_point.parcelcount
    IS 'The number of parcels the point can be found in';
-- Index: idx_pntdestdcad_gid

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntdestdcad_gid;

CREATE UNIQUE INDEX IF NOT EXISTS idx_pntdestdcad_gid
    ON xxSchemaxx.dest_point USING btree
    (gid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_pntdestdcad_layer

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntdestdcad_layer;

CREATE INDEX IF NOT EXISTS idx_pntdestdcad_layer
    ON xxSchemaxx.dest_point USING btree
    (srce_lyr COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_pntdestdcad_pointno

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntdestdcad_pointno;

CREATE UNIQUE INDEX IF NOT EXISTS idx_pntdestdcad_pointno
    ON xxSchemaxx.dest_point USING btree
    (pointno ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_pntdestdcadorig

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntdestdcadorig;

CREATE INDEX IF NOT EXISTS idx_pntdestdcadorig
    ON xxSchemaxx.dest_point USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: idx_pntdestdcadproj

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntdestdcadproj;

CREATE INDEX IF NOT EXISTS idx_pntdestdcadproj
    ON xxSchemaxx.dest_point USING gist
    (geom_proj)
    TABLESPACE pg_default;
