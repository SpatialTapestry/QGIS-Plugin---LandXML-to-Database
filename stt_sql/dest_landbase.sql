-- Table: xxSchemaxx.dest_landbase

-- DROP TABLE IF EXISTS xxSchemaxx.dest_landbase;

CREATE TABLE IF NOT EXISTS xxSchemaxx.dest_landbase
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
    CONSTRAINT giddestdcadlbpkey PRIMARY KEY (gid)
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.dest_landbase
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.dest_landbase
    IS 'This table simulates the master landbase/DCDB';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.objectid
    IS 'Unique ID for each landbase lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.gid
    IS 'A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.createdate
    IS 'The date the lot was loaded into the database';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.modifieddate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.planoid
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.lotnumber
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.sectionnumber
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.plannumber
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.planlabel
    IS 'unused, but carried through ''xxSchemaxx.'' schema and onto ''proposed'' schema';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.itslotid
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.stratumlevel
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.hasstratum
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.planlotarea
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.planlotareaunits
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.startdate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.enddate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.lastupdate
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.geom_orig
    IS 'Original Geometry';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.source
    IS 'The LGA or Supplier of the landbase lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.area
    IS 'The area in m2 of the lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.perimeter
    IS 'The perimeter in metres of the lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.minx
    IS 'The minimum easting of the lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.miny
    IS 'The minimum northing of the lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.maxx
    IS 'The maximum easting of the lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.maxy
    IS 'The maximum northing of the lot';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.midx
    IS 'mid = (min+max)/2';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.midy
    IS 'mid = (min+max)/2';

COMMENT ON COLUMN xxSchemaxx.dest_landbase.isvalid
    IS 'True is the geometry (geom_orig) is valid';
-- Index: idx_destdcad_area

-- DROP INDEX IF EXISTS xxSchemaxx.idx_destdcad_area;

CREATE INDEX IF NOT EXISTS idx_destdcad_area
    ON xxSchemaxx.dest_landbase USING btree
    (area ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_destdcad_geom_orig

-- DROP INDEX IF EXISTS xxSchemaxx.idx_destdcad_geom_orig;

CREATE INDEX IF NOT EXISTS idx_destdcad_geom_orig
    ON xxSchemaxx.dest_landbase USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: idx_destdcad_gid

-- DROP INDEX IF EXISTS xxSchemaxx.idx_destdcad_gid;

CREATE INDEX IF NOT EXISTS idx_destdcad_gid
    ON xxSchemaxx.dest_landbase USING btree
    (gid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_destdcad_perim

-- DROP INDEX IF EXISTS xxSchemaxx.idx_destdcad_perim;

CREATE INDEX IF NOT EXISTS idx_destdcad_perim
    ON xxSchemaxx.dest_landbase USING btree
    (perimeter ASC NULLS LAST)
    TABLESPACE pg_default;
