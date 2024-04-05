-- Table: xxSchemaxx.stt_dp_surveyline

-- DROP TABLE xxSchemaxx.stt_dp_surveyline;

CREATE TABLE xxSchemaxx.stt_dp_surveyline
(
  gid serial not null,
  lineno integer,
  pointno1 integer,
  setupid character varying(20),
  pointno2 integer,
  targetsetupid character varying(20),
  planlabel character varying(30),
  isvalid boolean,
  operator character varying(100),
  titlebear double precision,
  titledist double precision,
  titleradius double precision,
  title_dms character varying(13),
  linetype character varying(20),
  geom_orig geometry(LineString,xxxx),
  geom_adj geometry(LineString,xxxx),
  length_orig real,
  length_adj real,
  i1fbearcmo_deg real,
  ilfbearcmo_deg real,
  i1rbearcmo_deg real,
  ilrbearcmo_deg real,
  ildistcmo_m real,
  i1distcmo_m real,
  i1distclc_m real,
  ildistclc_m real,
  diffbear_deg real,
  diffdist_m real,
  useinlsa boolean,
  geom_dwn geometry(LineString,xxxx),
  purpose character varying(50)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE xxSchemaxx.stt_dp_surveyline
  OWNER TO postgres;
