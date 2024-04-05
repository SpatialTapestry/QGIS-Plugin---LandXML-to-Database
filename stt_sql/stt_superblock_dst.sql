-- Table: xxSchemaxx.stt_superblock_dst

-- DROP TABLE IF EXISTS xxSchemaxx.stt_superblock_dst;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_superblock_dst
(
    blockid SERIAL NOT NULL,
    geom_orig geometry(Polygon,xxxx),
    geom_cent geometry(Point,xxxx),
    geom_proj geometry(LineString,7855),
    area double precision,
    minx double precision,
    miny double precision,
    maxx double precision,
    maxy double precision,
    midx double precision,
    midy double precision,
    perimeter double precision,
    name character varying(16) COLLATE pg_catalog."default",
    sum_plans_lxml integer,
    sum_parcels integer,
    sum_bl integer,
    sum_dims integer,
    num_dims_per_cm integer,
    percent_bl_dims real,
    adjust_status character varying(16) COLLATE pg_catalog."default",
    adjust_accuracy real,
    adjust_lsa_date timestamp(0) without time zone,
    score_demand real,
    score_potential real,
    priority integer,
    assigned_by character varying(64) COLLATE pg_catalog."default",
    assigned_date timestamp(0) without time zone,
    schedule_seqid integer,
    last_adjust_date timestamp(0) without time zone,
    last_adjust_by character varying(64) COLLATE pg_catalog."default",
    last_adjust_type character varying(16) COLLATE pg_catalog."default",
    next_review_date date,
    num_dps_adjusted integer,
    num_dps_finalised integer,
    num_dcdb_matched integer,
    num_topology_errs integer,
    total_area_m double precision,
    average_area_m double precision,
    oldest_dp_date timestamp(0) without time zone,
    newest_dp_date timestamp(0) without time zone,
    islocked integer,
    locked_by character varying(64) COLLATE pg_catalog."default",
    lock_status character varying(16) COLLATE pg_catalog."default",
    lock_date timestamp(0) without time zone,
    created timestamp(0) without time zone,
    lastupdated timestamp(0) without time zone,
    geom_area_ha double precision,
    geom_buffered geometry(Geometry,xxxx),
    qa_status character varying(50) COLLATE pg_catalog."default",
    qa_by character varying(64) COLLATE pg_catalog."default",
    qa_date timestamp(0) without time zone,
    qa_comment character varying(64) COLLATE pg_catalog."default",
    areanodpparcelsm real,
    numdpsincsb integer,
    numprobdpsincsb integer,
    numcalcdpsincsb integer,
    numclassabcmons integer,
    csvclassabcmons character varying(200) COLLATE pg_catalog."default",
    numclassdmons integer,
    csvclassdmons character varying(200) COLLATE pg_catalog."default",
    numclassemons integer,
    csvclassemons character varying(200) COLLATE pg_catalog."default",
    numlotpntsleft integer,
    csvlotpntsleft character varying(200) COLLATE pg_catalog."default",
    maxparmisclosem real,
    maxmonmisclosem real,
    numpnts integer,
    numestim integer,
    bigshift real,
    aveshift real,
    bigangle real,
    aveangle real,
    biglen real,
    avelen real,
    percentmatched real,
    numlotpnts integer,
    numshftvct integer,
    avesvlength real,
    maxsvlength real,
    CONSTRAINT stt_superblock_dst_pkey PRIMARY KEY (blockid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_superblock_dst
    OWNER to rogermsu;

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.blockid
    IS 'A System generated unique record ';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.geom_orig
    IS 'The polygon geometry around the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.geom_cent
    IS 'The centre point geometry of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.area
    IS 'The area of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.minx
    IS 'The minimum easting of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.miny
    IS 'The minimum northing of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.maxx
    IS 'The maximum easting of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.maxy
    IS 'The maximum northing of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.midx
    IS 'mid = (min+max)/2';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.midy
    IS 'mid = (min+max)/2';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.perimeter
    IS 'The perimeter length of the super block';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_dst.name
    IS 'The name of the super block';
-- Index: superblock_dst_geom_buff

-- DROP INDEX IF EXISTS xxSchemaxx.superblock_dst_geom_buff;

CREATE INDEX IF NOT EXISTS superblock_dst_geom_buff
    ON xxSchemaxx.stt_superblock_dst USING gist
    (geom_buffered)
    TABLESPACE pg_default;
-- Index: superblock_dst_geom_orig

-- DROP INDEX IF EXISTS xxSchemaxx.superblock_dst_geom_orig;

CREATE INDEX IF NOT EXISTS superblock_dst_geom_orig
    ON xxSchemaxx.stt_superblock_dst USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: superblock_dst_geom_proj

-- DROP INDEX IF EXISTS xxSchemaxx.superblock_dst_geom_proj;

CREATE INDEX IF NOT EXISTS superblock_dst_geom_proj
    ON xxSchemaxx.stt_superblock_dst USING gist
    (geom_proj)
    TABLESPACE pg_default;
