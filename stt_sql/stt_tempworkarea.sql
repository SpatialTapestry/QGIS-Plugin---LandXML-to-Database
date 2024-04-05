-- Table: xxSchemaxx.stt_tempworkarea

-- DROP TABLE IF EXISTS xxSchemaxx.stt_tempworkarea;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_tempworkarea
(
    blockid SERIAL NOT NULL,
    gid SERIAL NOT NULL,
    name character varying(64) COLLATE pg_catalog."default",
    area double precision,
    adjust_status character varying(16) NOT NULL DEFAULT 'Unadjusted',
    last_adjust_date timestamp(0) without time zone,
    last_adjust_by character varying(64),
    last_adjust_type character varying(16) NOT NULL DEFAULT 'None',
    next_review_date date,
    num_dcdb_matched integer NOT NULL DEFAULT 0,
    islocked integer NOT NULL DEFAULT 0,
    locked_by character varying(64) COLLATE pg_catalog."default",
    lock_status character varying(16) COLLATE pg_catalog."default",
    lock_date timestamp(0) without time zone,
    qa_status character varying(50) COLLATE pg_catalog."default",
    qa_by character varying(64) COLLATE pg_catalog."default",
    qa_date timestamp(0) without time zone,
    qa_comment character varying(200) COLLATE pg_catalog."default",
    numpnts integer,
    numestim integer,
    numprobs integer,
    numtopo integer,
    numriparian integer,
    numvgeom integer,
    bigshift real,
    aveshift real,
    bigangle real,
    aveangle real,
    biglen real,
    avelen real,
    percentmatched real,
    adjustmenttodo boolean,
    adjustmentscript text COLLATE pg_catalog."default",
    adjustmentdata text COLLATE pg_catalog."default",
    adjustmentdone boolean,
    adjustmentresult text COLLATE pg_catalog."default",
    gda94sridproj integer,
    gda2020sridproj integer,
    savexxxxsdt boolean,
    saveprojsdt boolean,
    savesnapsdt boolean,
    geom_orig geometry(MultiPolygon,xxxx),
    CONSTRAINT st_twarea_blockid_key UNIQUE (blockid)
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_tempworkarea
    OWNER to rogermsu;

GRANT ALL ON TABLE xxSchemaxx.stt_tempworkarea TO PUBLIC;

GRANT ALL ON TABLE xxSchemaxx.stt_tempworkarea TO rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_tempworkarea
    IS 'This table holds the Temporary Work Area Polygons, which can be any size up to LGA size. These are used to manage the Shifting Cadastre problem where field assets and spatially dependant layers (e.g. road centrelines and annotation) need to be moved to fit a new landbase.';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.blockid
    IS 'The Super Block Identifier';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.gid
    IS 'A system generated Record IG';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.area
    IS 'The area in m2 of the TWA';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.adjust_status
    IS 'The adjustment status, e.g. Adjusting, Adjusted';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.last_adjust_date
    IS 'The date and time the last LSA was completed';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.last_adjust_by
    IS 'The Email address of the person requesting the LSA run';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.last_adjust_type
    IS 'The Adjustment Type, LSA = Least Squares Adjusment, IBG - Iterative Best Guess';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.next_review_date
    IS 'unused';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.num_dcdb_matched
    IS 'The number of landbase (DCDB) points with Shift Vectors';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.islocked
    IS 'Used by the Work Horse to prevent multiple processes processing the same TWA at the same time';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.locked_by
    IS 'The Email address of the person causing the PAA to be locked';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.lock_date
    IS 'The date and time the TWA was locked';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.qa_status
    IS 'Quality Assurance Status';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.qa_by
    IS 'The user name of the person running the adjustment';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.qa_date
    IS 'The date the adjustment runs';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.qa_comment
    IS 'Comments provided by the software indicating the progress through the adjustment';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.numpnts
    IS 'The number of points in the adjustment';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.numestim
    IS '??? not addressed';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.bigshift
    IS 'The maximum length of the movement of the landbase points (an indicator of some error)';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.aveshift
    IS 'The average length of the movements of the landbase points';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.bigangle
    IS 'The largest deflection of any corner in the landbase (an indicator of some error)';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.aveangle
    IS 'The average deflection of any corner in the landbase';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.biglen
    IS 'The maximum absolute ''change in length'' of the landbase point movements';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.avelen
    IS 'The average absolute ''change in length'' of the landbase point movements';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.percentmatched
    IS 'The percentage of unique landbase points with Shift Vectors (the higher the better)';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.adjustmenttodo
    IS '??? This is a flag for the SAM/SAE to run a Least Squares Adjustment on the TWA';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.adjustmentscript
    IS '??? This is the SAM/SAE Script to run';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.adjustmentdata
    IS '??? This is a very long string which defines all the points and sets of bearings and distances for the LSA to process';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.adjustmentdone
    IS '??? The Workhorse sets this to false and waits for the SAM/SAE to set this to true when the LSA is finished';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.adjustmentresult
    IS '??? The Workhorse sets this to an empty string and waits for the SAM/SAE to set this to a list of adjusted coordinates when the LSA finishes';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.gda94sridproj
    IS 'Part of the NTV2020 Workflow';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.gda2020sridproj
    IS 'Part of the NTV2020 Workflow';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.savexxxxsdt
    IS 'Part of the NTV2020 Workflow';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.saveprojsdt
    IS 'Part of the NTV2020 Workflow';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.savesnapsdt
    IS 'Part of the NTV2020 Workflow';

COMMENT ON COLUMN xxSchemaxx.stt_tempworkarea.geom_orig
    IS 'The geometry of the TWA';
-- Index: idx_tempworkarea_geomorig

-- DROP INDEX IF EXISTS xxSchemaxx.idx_tempworkarea_geomorig;

CREATE INDEX IF NOT EXISTS idx_tempworkarea_geomorig
    ON xxSchemaxx.stt_tempworkarea USING gist
    (geom_orig)
    TABLESPACE pg_default;
