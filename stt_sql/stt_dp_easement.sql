-- Table: xxSchemaxx.stt_dp_easement

-- DROP TABLE xxSchemaxx.stt_dp_easement;

CREATE TABLE xxSchemaxx.stt_dp_easement
(
  gid serial not null,
  planlabel character varying(30),
  easementname character varying(32),
  class character varying(30),
  state character varying(30),
  parceltype character varying(30),
  description character varying(512),
  datecollected date,
  geom_orig geometry(Polygon,xxxx),
  geom_adj geometry(Polygon,xxxx),
  geom_dwn geometry(Polygon,xxxx),
  parcelformat character varying(30),
  center_pref character varying(30),
  cent_orig geometry(Point,xxxx),
  cent_adj geometry(Point,xxxx),
  parcelmisclosem real,
  parcelmisclosed character varying(15),
  aream2title double precision,
  aream2calced double precision,
  aream2diff double precision,
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
ALTER TABLE xxSchemaxx.stt_dp_easement
  OWNER TO postgres;
