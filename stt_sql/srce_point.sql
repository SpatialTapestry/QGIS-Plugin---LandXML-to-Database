-- Table: xxSchemaxx.srce_point

-- DROP TABLE IF EXISTS xxSchemaxx.srce_point;

CREATE TABLE IF NOT EXISTS xxSchemaxx.srce_point
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
    geom_orig geometry(Point,7844),
    srce_lyr character varying(50) COLLATE pg_catalog."default",
    have_shiftvector boolean DEFAULT false,
    parcelcount integer,
    oncsbbdy boolean DEFAULT false,
    incsbbdy boolean DEFAULT false,
    outcsbbdy boolean DEFAULT true,
    dist2sv real DEFAULT 1000,
    dist2csb real DEFAULT 1000,
    geom_proj geometry(Point,7855),
    geom_adj geometry(Point,7844),
    numpnts integer,
    numestim integer,
    bigshift real,
    aveshift real,
    bigangle real,
    aveangle real,
    biglen real,
    avelen real,
    geom_prop geometry(Geometry,7844),
    have_posnequ boolean DEFAULT false,
    posnequsizem real,
    useascontrol boolean DEFAULT false,
    CONSTRAINT gidsrcedcadpntpkey PRIMARY KEY (gid)
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.srce_point
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.srce_point
    IS 'This table is populated from public.stt_point, it contains extra fields to help with various work flows.';

COMMENT ON COLUMN xxSchemaxx.srce_point.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.srce_point.pointno
    IS 'A Point Number for each point record, sourced from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.srce_point.blockid
    IS 'The Temporary Work Area the point is in, sourced from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.srce_point.jobid
    IS 'The Job Id of the workflow which caused the point record to be copied from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.srce_point.paa_id
    IS 'The Plan Adjustment Area Id the point is in, sourced from public.stt_point';

COMMENT ON COLUMN xxSchemaxx.srce_point.nodetype
    IS 'Used in the software for various processes, including Shift Vector generation';

COMMENT ON COLUMN xxSchemaxx.srce_point.adj_status
    IS 'The adjustment status';

COMMENT ON COLUMN xxSchemaxx.srce_point.onanarc
    IS 'True if the software detects anc arc, such as a cal de sac';

COMMENT ON COLUMN xxSchemaxx.srce_point.geom_orig
    IS 'The point geometry for the original coordinates';

COMMENT ON COLUMN xxSchemaxx.srce_point.srce_lyr
    IS 'The layer that the point was first found in, usually the landbase, but also road centre lines, suburbs, mesh blocks, etc';

COMMENT ON COLUMN xxSchemaxx.srce_point.have_shiftvector
    IS 'True if the point has been given a shift vector';

COMMENT ON COLUMN xxSchemaxx.srce_point.parcelcount
    IS 'The number of parcels the point can be found in';

COMMENT ON COLUMN xxSchemaxx.srce_point.geom_adj
    IS 'The adjusted coordinates, from CSB, TWA or PAA processing';
-- Index: idx_pntsrcedcad_gid

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntsrcedcad_gid;

CREATE UNIQUE INDEX IF NOT EXISTS idx_pntsrcedcad_gid
    ON xxSchemaxx.srce_point USING btree
    (gid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_pntsrcedcad_layer

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntsrcedcad_layer;

CREATE INDEX IF NOT EXISTS idx_pntsrcedcad_layer
    ON xxSchemaxx.srce_point USING btree
    (srce_lyr COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_pntsrcedcad_pointno

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntsrcedcad_pointno;

CREATE UNIQUE INDEX IF NOT EXISTS idx_pntsrcedcad_pointno
    ON xxSchemaxx.srce_point USING btree
    (pointno ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_pntsrcedcadadj

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntsrcedcadadj;

CREATE INDEX IF NOT EXISTS idx_pntsrcedcadadj
    ON xxSchemaxx.srce_point USING gist
    (geom_adj)
    TABLESPACE pg_default;
-- Index: idx_pntsrcedcadorig

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntsrcedcadorig;

CREATE INDEX IF NOT EXISTS idx_pntsrcedcadorig
    ON xxSchemaxx.srce_point USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: idx_pntsrcedcadproj

-- DROP INDEX IF EXISTS xxSchemaxx.idx_pntsrcedcadproj;

CREATE INDEX IF NOT EXISTS idx_pntsrcedcadproj
    ON xxSchemaxx.srce_point USING gist
    (geom_proj)
    TABLESPACE pg_default;
