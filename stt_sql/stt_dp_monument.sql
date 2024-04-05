-- Table: xxSchemaxx.stt_dp_monument

-- DROP TABLE xxSchemaxx.stt_dp_monument;

CREATE TABLE xxSchemaxx.stt_dp_monument
(
  gid SERIAL NOT NULL,
  planlabel character varying(30),
  monumentname character varying(32),
  state character varying(32),
  pntref character varying(32),
  type character varying(32),
  geom_orig geometry(Point,xxxx),
  datecollected date,
  ctrlclass character varying(1),
  ctrlorder character varying(1),
  geom_dwn geometry(Point,xxxx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE xxSchemaxx.stt_dp_monument
  OWNER TO postgres;
