-- Table: xxSchemaxx.stt_plandata

-- DROP TABLE IF EXISTS xxSchemaxx.stt_plandata;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_plandata
(
    gid SERIAL NOT NULL,
    planlabel character varying(200) COLLATE pg_catalog."default",
    plantype character varying(2) COLLATE pg_catalog."default",
    surveyorname character varying(100) COLLATE pg_catalog."default",
    datesurveyed date,
    dateregistered date,
    dateretired date,
    planrotndeg double precision,
    approxlevelm real,
    operator character varying(100) COLLATE pg_catalog."default",
    datecreated date,
    isvalid boolean,
    adjustyn boolean,
    searchdist real,
    buildposnequs boolean,
    posnequdist real,
    posequonorig boolean,
    adoptascontrol boolean,
    onofftoggle boolean,
    landxmlastext text COLLATE pg_catalog."default",
    transformparas xml,
    needssvgpng boolean,
    mbr_orig geometry,
    mbr_adj geometry,
    geom_adj geometry(MultiPolygon,xxxx),
    geom_orig geometry(MultiPolygon,xxxx),
    geom_dwn geometry(MultiPolygon,xxxx),
    geom_zoi geometry(MultiPolygon,xxxx),
    dist_zoi real DEFAULT '-1'::integer,
    nummonuments integer,
    numconfixdppnts integer,
    numshiftvectors integer,
    combinedscore integer,
    numparcels integer,
    numcgpnts integer,
    numdcdbsvs integer,
    loadstatus character varying(100) COLLATE pg_catalog."default",
    loaddate timestamp(0) without time zone,
    loadedby character varying(64) COLLATE pg_catalog."default",
    batchid integer,
    numcoordmons integer,
    numclassabcmons integer,
    numclassdmons integer,
    numclassemons integer,
    iscoordinated boolean,
    isdowngraded boolean,
    hasbeenlsad boolean,
    maxparmisclosem real,
    maxmonmisclosem real,
    needsshiftvectors boolean,
    paatwacsb character varying(5) COLLATE pg_catalog."default",
    paatwacsbuid character varying(30) COLLATE pg_catalog."default",
    datelastchanged timestamp(0) without time zone,
    last_adjust_date timestamp(0) without time zone,
    numpnts integer,
    numestim integer,
    bigshift real,
    aveshift real,
    bigangle real,
    aveangle real,
    biglen real,
    avelen real,
    geom_prop geometry(Geometry,xxxx),
    loadcomment character varying(200) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_plandata
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_plandata
    IS 'This is the metadata for each landXML/GeoJSon/CEXML file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.gid
    IS 'A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.planlabel
    IS 'The plan label for the landXML/GeoJSon/CEXML file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.plantype
    IS 'The plan type, TP, LP, SP, etc';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.surveyorname
    IS 'The surveyor''s name';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.datesurveyed
    IS 'The date of survey';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.dateregistered
    IS 'The date the plan was registered';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.dateretired
    IS 'If retired, the retirement date';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.planrotndeg
    IS 'not used - see ''transformparas'' below';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.approxlevelm
    IS 'If known, the approximate level';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.operator
    IS 'The operators name, if known';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.datecreated
    IS 'The date the file was loaded';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.isvalid
    IS 'True if there were no problems detected';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.adjustyn
    IS 'Set to True by default, for LSA and fit2Fabric purposes';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.searchdist
    IS '??? is dist_zoi used instead ???';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.buildposnequs
    IS 'False by default, but is used to tell the LSA to build Position Equations on the plans CG Points to add stability during a LSA';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.posnequdist
    IS 'If buildposnequs is true, this is the Standard Deviation of the Position Equation';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.posequonorig
    IS 'If buildposnequs, then if this is true then Position Equations are built on the original coordinates, otherwise on the adjusted coordinates from the previous iteration';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.adoptascontrol
    IS 'When running a LSA, setting this to be true means the CG Points in this plan become control points';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.onofftoggle
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.landxmlastext
    IS 'the landXML, GeoJSon or CEXML file contents';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.transformparas
    IS 'The transformation parameters (if any) in an XML format';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.needssvgpng
    IS 'If true, a Scalable Vector Graphics or PNG File will/can be produced';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.mbr_orig
    IS 'A polygon geometry representing the Minimum Bounding Rectangle of the combined parcels';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.mbr_adj
    IS 'A polygon geometry representing the Minimum Bounding Rectangle of the adjusted combined parcels';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.geom_adj
    IS 'A polygon geometry representing the all buffered adjusted objects in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.geom_orig
    IS 'A polygon geometry representing the all buffered objects in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.geom_dwn
    IS 'A polygon geometry representing the all buffered downgraded objects in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.geom_zoi
    IS 'A polygon geometry representing the all buffered buffered (ZOI distance) in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.dist_zoi
    IS 'The Zone of Influence Distance in metres';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.nummonuments
    IS 'The number of Monuments in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numconfixdppnts
    IS 'The number of Control/Fixed points in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numshiftvectors
    IS 'unused - The number of Shift Vectors generated for the plan';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.combinedscore
    IS 'A measure of how successfully the shift vector generation was';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numparcels
    IS 'The number of Parcels in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numcgpnts
    IS 'The number of CG Points in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numdcdbsvs
    IS 'The number of DCDB/landbasr Shift Vectos in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.loadstatus
    IS 'The load Status, Pending, Success, Shift Vectors Done, etc';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.loaddate
    IS 'The date and time the file was loaded into this table';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.loadedby
    IS 'The email of the person who uploaded the file, or FTP when loaded automatically by the FTP Loader';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.batchid
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numcoordmons
    IS 'The number of coordinated Monuments in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numclassabcmons
    IS 'The number of Clas A, B or C Monuments in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numclassdmons
    IS 'The number of class D Monuments in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.numclassemons
    IS 'The number of class E Monuments in the file';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.iscoordinated
    IS 'This is a flag used by the Workhorse to track if a plan is connected to 2 or more control points, and if a plan is connected (via Shift Vectors) by 2 or more common CG Points to a plan with 2 or more control points, etc. This ultimately sets what plans can go to the LSA';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.isdowngraded
    IS 'This is set if the plan has been through the fit2Fabric (downgraded) work flow';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.hasbeenlsad
    IS 'This is set if the plan has been through the Least Squares Adjustment (upgraded) work flow';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.maxparmisclosem
    IS 'This records the largest Parcel misclose for the plan';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.maxmonmisclosem
    IS 'This records the largest misclose between Monuments in the plan';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.needsshiftvectors
    IS 'This records whether or not the Workhorse needs to generate Shift Vectors for the plan the Workhorse setting it to false once completed';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.paatwacsb
    IS 'This records what type of process the plan was used in, PAA, TWA or CSB';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.paatwacsbuid
    IS 'This records the PAA, TWA or CSB Id the plan was last used in';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.datelastchanged
    IS 'The date something changed in relation to this plan';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.last_adjust_date
    IS 'The date of the last LSA run';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.bigshift
    IS 'The maximum length of the movement of the CG points (an indicator of some error)';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.aveshift
    IS 'The average length of the movements of the CG points';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.bigangle
    IS 'The largest deflection of any corner in the plan (an indicator of some error)';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.aveangle
    IS 'The average deflection of any corner in the plan';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.biglen
    IS 'The maximum absolute ''change in length'' of the traverse line';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.avelen
    IS 'The average absolute ''change in length'' of the traverse lines';

COMMENT ON COLUMN xxSchemaxx.stt_plandata.loadcomment
    IS 'The last comment by the software in the various work flows that take place';
-- Index: xxSchemaxx_idx_stt_plandataa

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_plandataa;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_plandataa
    ON xxSchemaxx.stt_plandata USING gist
    (mbr_adj)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_plandatao

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_plandatao;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_plandatao
    ON xxSchemaxx.stt_plandata USING gist
    (mbr_orig)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_stt_plannumber

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_plannumber;

CREATE UNIQUE INDEX IF NOT EXISTS xxSchemaxx_stt_plannumber
    ON xxSchemaxx.stt_plandata USING btree
    (planlabel COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
