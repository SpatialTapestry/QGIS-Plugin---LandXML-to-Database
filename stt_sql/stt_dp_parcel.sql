-- Table: xxSchemaxx.stt_dp_parcel

-- DROP TABLE xxSchemaxx.stt_dp_parcel;

CREATE TABLE xxSchemaxx.stt_dp_parcel
(
  gid serial not null,
  planlabel character varying(30),
  sectionname character varying(10),
  parcelname character varying(32),
  geom_orig geometry(GEOMETRY,xxxx),
  geom_adj geometry(GEOMETRY,xxxx),
  datecollected date,
  class character varying(30),
  state character varying(30),
  parceltype character varying(30),
  parcelformat character varying(30),
  center_pref character varying(30),
  cent_orig geometry(Point,xxxx),
  cent_adj geometry(Point,xxxx),
  parcelmisclosem real,
  parcelmisclosed character varying(15),
  geom_dwn geometry(GEOMETRY,xxxx),
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
  geomvalid boolean,
  description character varying(512)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE xxSchemaxx.stt_dp_parcel
  OWNER TO postgres;
