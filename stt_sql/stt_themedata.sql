-- Table: xxSchemaxx.stt_themedata

-- DROP TABLE IF EXISTS xxSchemaxx.stt_themedata;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_themedata
(
    rowno integer,
    ipaddress character varying(32) COLLATE pg_catalog."default",
    databasename character varying(64) COLLATE pg_catalog."default",
    schemaname character varying(64) COLLATE pg_catalog."default",
    username character varying(64) COLLATE pg_catalog."default",
    userpassword character varying(64) COLLATE pg_catalog."default",
    dbport character varying(10) COLLATE pg_catalog."default",
    themename character varying(512) COLLATE pg_catalog."default",
    themeuidcol character varying(64) COLLATE pg_catalog."default",
    connectiontype character varying(10) COLLATE pg_catalog."default",
    srceschemaname character varying(64) COLLATE pg_catalog."default",
    srcethemename character varying(512) COLLATE pg_catalog."default",
    srcethemeuidcol character varying(64) COLLATE pg_catalog."default",
    srceoriggeomfldname character varying(32) COLLATE pg_catalog."default",
    fme_rw_dirparam character varying(5000) COLLATE pg_catalog."default",
    origgeomfldname character varying(32) COLLATE pg_catalog."default",
    adjgeomfldname character varying(32) COLLATE pg_catalog."default",
    geometrytype character varying(32) COLLATE pg_catalog."default",
    use_st_overlaps boolean,
    renderthistheme boolean,
    renderpriority smallint,
    rendercolour integer,
    linethickness character varying(10) COLLATE pg_catalog."default",
    infillcolour character varying(32) COLLATE pg_catalog."default",
    infillbitmap character varying(128) COLLATE pg_catalog."default",
    adjustable boolean,
    scaledobject boolean DEFAULT false,
    rigidobject boolean DEFAULT false,
    allowrotation boolean,
    snaptosnaptothemes boolean,
    isatargetsnaptheme boolean,
    themetype character varying(32) COLLATE pg_catalog."default",
    maintainstraightlines boolean DEFAULT false,
    straightenthelines boolean,
    straightlinetolcm real,
    maxdeflnangledeg real,
    maintainimpverttopo boolean DEFAULT false,
    maintainintbearing boolean DEFAULT false,
    sdgroupfieldname character varying(32) COLLATE pg_catalog."default",
    sdgroupname character varying(32) COLLATE pg_catalog."default",
    removespikes boolean DEFAULT true,
    removespikestolmm real DEFAULT 5,
    reportstats boolean,
    labeltheme boolean DEFAULT false,
    labelfield character varying(64) COLLATE pg_catalog."default",
    gpkg_sql character varying(64000) COLLATE pg_catalog."default",
    minimumscale integer DEFAULT 1000,
    maximumscale integer DEFAULT 1,
    issrstheme boolean
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_themedata
    OWNER to rogermsu;