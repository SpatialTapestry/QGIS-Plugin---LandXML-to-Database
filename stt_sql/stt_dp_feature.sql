-- Table: xxSchemaxx.stt_dp_feature

-- DROP TABLE xxSchemaxx.stt_dp_feature;

CREATE TABLE xxSchemaxx.stt_dp_feature
(
  gid serial not null,
  planlabel character varying(30),
  featurename character varying(32),
  class character varying(30),
  state character varying(30),
  parceltype character varying(30),
  description character varying(512),
  datecollected date,
  geom_orig geometry(LineString,xxxx),
  geom_adj geometry(LineString,xxxx),
  geom_dwn geometry(LineString,xxxx),
  numpnts integer,
  numestim integer,
  bigshift double precision,
  aveshift double precision,
  bigangle double precision,
  aveangle double precision,
  biglen double precision,
  avelen double precision,
  geomvalid boolean
)
WITH (
  OIDS=FALSE
);
ALTER TABLE xxSchemaxx.stt_dp_feature
  OWNER TO postgres;
