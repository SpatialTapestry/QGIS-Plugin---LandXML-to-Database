-- Table: xxSchemaxx.stt_vectorcgpoint

-- DROP TABLE IF EXISTS xxSchemaxx.stt_vectorcgpoint;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_vectorcgpoint
(
    gid SERIAL NOT NULL,
    planlabel character varying(30) COLLATE pg_catalog."default" NOT NULL,
    cgpntname character varying(32) COLLATE pg_catalog."default" NOT NULL,
    stt_pointno integer NOT NULL,
    scoretag character varying(10) COLLATE pg_catalog."default" NOT NULL,
    scoreval integer NOT NULL,
    blockid integer,
    datecollected timestamp without time zone,
    ischecked boolean NOT NULL DEFAULT false,
    geom_orig geometry(LineString,xxxx),
    geom_adj geometry(LineString,xxxx),
    geom_dwn geometry(LineString,xxxx),
    numpnts integer,
    numestim integer,
    bigshift real,
    aveshift real,
    bigangle real,
    aveangle real,
    biglen real,
    avelen real,
    geom_prop geometry(Geometry,xxxx),
    cg_gid integer,
    tag character varying(30) COLLATE pg_catalog."default",
    inscope boolean,
    csbno integer
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_vectorcgpoint
    OWNER to rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_vectorcgpoint
    IS 'This table hold both the generated and human collected shift vectors between the landbase and the CG Points in the landXML, GoeJSon and CEXML, as well as any edits';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.gid
    IS ' A System generated unique record UID';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.planlabel
    IS 'The Plan Label the shift vector connects to';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.cgpntname
    IS 'The CG Point name/label the shift vector connects to';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.stt_pointno
    IS 'The landbase Point Number the shift vector connects to';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.scoretag
    IS 'The routine that made this shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.scoreval
    IS 'A score for the shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.blockid
    IS 'The TWA Block If the shift vector is in';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.datecollected
    IS 'The date and time that the shift vector was save to this table';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.ischecked
    IS 'For future enhancements to record if a human has checked the shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.geom_orig
    IS 'The linestring geometry from the landbase point to the plan point';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.geom_adj
    IS 'The adjusted linestring geometry from the landbase point to the plan point post LSA';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.geom_dwn
    IS 'The downgraded linestring geometry from the landbase point to the plan point post fit2Plan';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.cg_gid
    IS 'The GG Point GID';

COMMENT ON COLUMN xxSchemaxx.stt_vectorcgpoint.csbno
    IS 'the Cadastral Super Block the shiftvector is in';
-- Index: xxSchemaxx_idx_dpcgi_vpe_c

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_dpcgi_vpe_c;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_dpcgi_vpe_c
    ON xxSchemaxx.stt_vectorcgpoint USING gist
    (geom_orig)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_idx_stt_dpcgi_a

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_idx_stt_dpcgi_a;

CREATE INDEX IF NOT EXISTS xxSchemaxx_idx_stt_dpcgi_a
    ON xxSchemaxx.stt_vectorcgpoint USING gist
    (geom_adj)
    TABLESPACE pg_default;
-- Index: xxSchemaxx_stt_dpcgi_dp

-- DROP INDEX IF EXISTS xxSchemaxx.xxSchemaxx_stt_dpcgi_dp;

CREATE INDEX IF NOT EXISTS xxSchemaxx_stt_dpcgi_dp
    ON xxSchemaxx.stt_vectorcgpoint USING btree
    (planlabel COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
