-- Table: xxSchemaxx.stt_dp_cgpoint

-- DROP TABLE xxSchemaxx.stt_dp_cgpoint;

CREATE TABLE xxSchemaxx.stt_dp_cgpoint
(
  gid serial not null,
  planlabel character varying(30),
  cgname character varying(32),
  pntsurv character varying(32),
  description character varying(64),
  state character varying(32),
  geom_orig geometry(Point,xxxx),
  datecollected date,
  geom_mast geometry(Point,xxxx),
  geogorigastext character varying(200),
  mgaorigastext character varying(200),
  issvpoint boolean,
  geom_dwn geometry(Point,xxxx),
  adjbylsa boolean,
  adjbyibg boolean
)
WITH (
  OIDS=FALSE
);
ALTER TABLE xxSchemaxx.stt_dp_cgpoint
  OWNER TO postgres;
