-- Table: xxSchemaxx.stt_superblock_src

-- DROP TABLE IF EXISTS xxSchemaxx.stt_superblock_src;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_superblock_src
(
    blockid SERIAL NOT NULL,
    geom_orig geometry(Polygon,xxxx),
    geom_cent geometry(Point,xxxx),
    geom_proj geometry(LineString,7855),
    geom_biga geometry(Point,xxxx),
    area double precision,
    minx double precision,
    miny double precision,
    maxx double precision,
    maxy double precision,
    midx double precision,
    midy double precision,
    perimeter double precision,
    paaid integer,
    dest_blockp1 integer DEFAULT 0,
    dest_blockp2 integer DEFAULT 0,
    dest_blockp3 integer DEFAULT 0,
    geom_shiftvp1 geometry(LineString,xxxx),
    geom_shiftvp2 geometry(LineString,xxxx),
    geom_shiftvp3 geometry(LineString,xxxx),
    name character varying(16) COLLATE pg_catalog."default",
    description character varying(64) COLLATE pg_catalog."default",
    sum_plans integer,
    sum_parcels integer,
    adjust_status character varying(16) COLLATE pg_catalog."default",
    assigned_by character varying(64) COLLATE pg_catalog."default",
    last_adjust_date timestamp(0) without time zone,
    last_adjust_by character varying(64) COLLATE pg_catalog."default",
    last_adjust_type character varying(16) COLLATE pg_catalog."default",
    num_dps_adjusted integer,
    num_dcdb_matched integer,
    num_topology_errs integer,
    total_area_m double precision,
    average_area_m double precision,
    oldest_dp_date timestamp(0) without time zone,
    newest_dp_date timestamp(0) without time zone,
    islocked integer,
    locked_by character varying(64) COLLATE pg_catalog."default",
    lock_date timestamp(0) without time zone,
    qa_status character varying(50) COLLATE pg_catalog."default",
    qa_by character varying(64) COLLATE pg_catalog."default",
    qa_date timestamp(0) without time zone,
    qa_comment character varying(200) COLLATE pg_catalog."default",
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
    numcontrol integer,
    numadjusted integer,
    numiterations integer,
    numobservations integer,
    numsets integer,
    aposteriori double precision,
    avedirncorn double precision,
    avedistcorn double precision,
    adjustmenttodo boolean,
    adjustmentdata text COLLATE pg_catalog."default",
    adjustmentdone boolean,
    adjustmentresult text COLLATE pg_catalog."default",
    adjustmentscript text COLLATE pg_catalog."default",
    geom_alt geometry(Polygon,xxxx),
    twaid integer,
    lastupdated timestamp(0) without time zone,
    areanodpparcelsm real,
    gda94sridproj integer,
    gda2020sridproj integer,
    savexxxxsdt boolean,
    saveprojsdt boolean,
    savesnapsdt boolean,
    diagdirn real,
    diagdist real,
    CONSTRAINT stt_superblock_src_pkey PRIMARY KEY (blockid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_superblock_src
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_superblock_src
    IS 'The Cadastral Super Block (CSB) Table. This table is generated via SQL Scripts from the landbase';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_src.blockid
    IS 'A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_superblock_src.geom_orig
    IS 'The polygon geometry around the super block';
-- Index: csb_src_blockid

-- DROP INDEX IF EXISTS xxSchemaxx.csb_src_blockid;

CREATE INDEX IF NOT EXISTS csb_src_blockid
    ON xxSchemaxx.stt_superblock_src USING btree
    (blockid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: csb_src_geom_orig

-- DROP INDEX IF EXISTS xxSchemaxx.csb_src_geom_orig;

CREATE INDEX IF NOT EXISTS csb_src_geom_orig
    ON xxSchemaxx.stt_superblock_src USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: csb_src_geom_proj

-- DROP INDEX IF EXISTS xxSchemaxx.csb_src_geom_proj;

CREATE INDEX IF NOT EXISTS csb_src_geom_proj
    ON xxSchemaxx.stt_superblock_src USING gist
    (geom_proj)
    TABLESPACE pg_default;
-- Index: csb_src_paaid

-- DROP INDEX IF EXISTS xxSchemaxx.csb_src_paaid;

CREATE INDEX IF NOT EXISTS csb_src_paaid
    ON xxSchemaxx.stt_superblock_src USING btree
    (paaid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: superblock_src_geom_buff

-- DROP INDEX IF EXISTS xxSchemaxx.superblock_src_geom_buff;

CREATE INDEX IF NOT EXISTS superblock_src_geom_buff
    ON xxSchemaxx.stt_superblock_src USING gist
    (geom_alt)
    TABLESPACE pg_default;
