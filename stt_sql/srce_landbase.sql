-- Table: xxSchemaxx.srce_landbase

-- DROP TABLE IF EXISTS xxSchemaxx.srce_landbase;

CREATE TABLE IF NOT EXISTS xxSchemaxx.srce_landbase
(
    objectid integer NOT NULL,
    gid SERIAL NOT NULL,
    createdate timestamp(0) without time zone NOT NULL,
    modifieddate timestamp(0) without time zone,
    planoid integer,
    lotnumber character varying(16) COLLATE pg_catalog."default",
    sectionnumber character varying(3) COLLATE pg_catalog."default",
    plannumber integer,
    planlabel character varying(15) COLLATE pg_catalog."default",
    jobid integer,
    geom_adj geometry(MultiPolygon,xxxx),
    dest_lblotp1 integer DEFAULT 0,
    dest_lblotp2 integer DEFAULT 0,
    dest_lblotp3 integer DEFAULT 0,
    geom_shiftvp1 geometry(LineString,xxxx),
    geom_shiftvp2 geometry(LineString,xxxx),
    geom_shiftvp3 geometry(LineString,xxxx),
    itslotid integer,
    stratumlevel smallint,
    hasstratum smallint,
    planlotarea numeric(20,5),
    planlotareaunits character varying(6) COLLATE pg_catalog."default",
    startdate timestamp(0) without time zone,
    enddate timestamp(0) without time zone,
    lastupdate timestamp(3) without time zone,
    geom_orig geometry(MultiPolygon,xxxx),
    source character varying(20) COLLATE pg_catalog."default",
    area double precision,
    perimeter double precision,
    minx double precision,
    miny double precision,
    maxx double precision,
    maxy double precision,
    midx double precision,
    midy double precision,
    isvalid boolean,
    geom_biga geometry(Point,xxxx),
    bigangleposn integer,
    numpnts integer,
    numestim integer,
    bigshift double precision,
    aveshift double precision,
    bigangle double precision,
    aveangle double precision,
    biglen double precision,
    avelen double precision,
    CONSTRAINT gidsrcedcadlbpkey PRIMARY KEY (gid)
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.srce_landbase
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.srce_landbase
    IS 'This table simulates the master landbase/DCDB';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.objectid
    IS 'Unique ID for each landbase lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.gid
    IS 'A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.createdate
    IS 'The date the lot was loaded into the database';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.modifieddate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.planoid
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.lotnumber
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.sectionnumber
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.plannumber
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.planlabel
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.itslotid
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.stratumlevel
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.hasstratum
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.planlotarea
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.planlotareaunits
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.startdate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.enddate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.lastupdate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.geom_orig
    IS 'Original Geometry';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.source
    IS 'The LGA or Supplier of the landbase lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.area
    IS 'The area in m2 of the lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.perimeter
    IS 'The perimeter in metres of the lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.minx
    IS 'The minimum easting of the lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.miny
    IS 'The minimum northing of the lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.maxx
    IS 'The maximum easting of the lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.maxy
    IS 'The maximum northing of the lot';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.midx
    IS 'mid = (min+max)/2';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.midy
    IS 'mid = (min+max)/2';

COMMENT ON COLUMN xxSchemaxx.srce_landbase.isvalid
    IS 'True is the geometry (geom_orig) is valid';
-- Index: idx_srcedcad_area

-- DROP INDEX IF EXISTS xxSchemaxx.idx_srcedcad_area;

CREATE INDEX IF NOT EXISTS idx_srcedcad_area
    ON xxSchemaxx.srce_landbase USING btree
    (area ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_srcedcad_geom_orig

-- DROP INDEX IF EXISTS xxSchemaxx.idx_srcedcad_geom_orig;

CREATE INDEX IF NOT EXISTS idx_srcedcad_geom_orig
    ON xxSchemaxx.srce_landbase USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: idx_srcedcad_gid

-- DROP INDEX IF EXISTS xxSchemaxx.idx_srcedcad_gid;

CREATE INDEX IF NOT EXISTS idx_srcedcad_gid
    ON xxSchemaxx.srce_landbase USING btree
    (gid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_srcedcad_perim

-- DROP INDEX IF EXISTS xxSchemaxx.idx_srcedcad_perim;

CREATE INDEX IF NOT EXISTS idx_srcedcad_perim
    ON xxSchemaxx.srce_landbase USING btree
    (perimeter ASC NULLS LAST)
    TABLESPACE pg_default;

    
