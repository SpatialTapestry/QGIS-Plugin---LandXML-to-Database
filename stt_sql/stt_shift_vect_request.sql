-- Table: xxSchemaxx.stt_shift_vect_request

-- DROP TABLE IF EXISTS xxSchemaxx.stt_shift_vect_request;

CREATE TABLE IF NOT EXISTS xxSchemaxx.stt_shift_vect_request
(
    jobstatus character varying(100) COLLATE pg_catalog."default",
    jobqueue integer,
    requested_by character varying(100) COLLATE pg_catalog."default",
    date_submitted timestamp(0) without time zone,
    date_processed timestamp(0) without time zone,
    paatwatablename character varying(100),
    approach2use integer,
    num_std_devs integer,
    allowxyshifts boolean,
    searchdist_m real,
    plusconstant real,
    snaptolm real NOT NULL DEFAULT 0.10,
    svrid integer,
    geom_orig geometry(MultiPolygon,xxxx),
    source_planlabel character varying(300) COLLATE pg_catalog."default",
    source_ipaddr character varying(15) COLLATE pg_catalog."default",
    source_dbname character varying(30) COLLATE pg_catalog."default",
    source_username character varying(30) COLLATE pg_catalog."default",
    source_password character varying(30) COLLATE pg_catalog."default",
    source_port character varying(10) COLLATE pg_catalog."default",
    source_themename character varying(30) COLLATE pg_catalog."default",
    source_uidfield character varying(30) COLLATE pg_catalog."default",
    source_paaid integer,
    source_csbid integer,
    destination_ipaddr character varying(15) COLLATE pg_catalog."default",
    destination_dbname character varying(30) COLLATE pg_catalog."default",
    destination_username character varying(30) COLLATE pg_catalog."default",
    destination_password character varying(30) COLLATE pg_catalog."default",
    destination_port character varying(10) COLLATE pg_catalog."default",
    destination_themename character varying(30) COLLATE pg_catalog."default",
    destination_uidfield character varying(30) COLLATE pg_catalog."default",
    geom_prop geometry(Geometry,xxxx)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS xxSchemaxx.stt_shift_vect_request
    OWNER to rogermsu;

GRANT ALL ON TABLE xxSchemaxx.stt_shift_vect_request TO rogermsu;

COMMENT ON TABLE xxSchemaxx.stt_shift_vect_request
    IS 'This table works as the communication channel between the Rest Server and the Workhorse(s). Any task likely to take more than a few seconds, and can be handed over to the Workhorse, is written to this table. The Workhorse(s) poll this table looking for processes/work flows to process';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.jobstatus
    IS 'All jobs go through a range of Status, depending on the type of job, A Least Squares Adjustment is very different to a fit2Fabric job. All jobs start with a Job Status of ''open''';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.jobqueue
    IS 'Each Workhorse has a range of job queues it processes, nomunally a maximum number of 100. This is used to spread the load between one to may workhorses.';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.requested_by
    IS 'The email address of the person who requested a job to be run';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.date_submitted
    IS 'The date and time the job was recorded';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.date_processed
    IS 'The date and time the job was completed';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.paatwatablename
    IS 'Either ''stt_planadjarea'', ''stt_tempworkarea'' or ''stt_superblock''';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.approach2use
    IS 'This number tells the workhorse what workflow needs to be carried out';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.num_std_devs
    IS 'The Number of Standard Deviations to use is used to cull larger Shift Vectors that are most likely to be in error';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.allowxyshifts
    IS 'This allows the average X & Y shifts to be used to cull larger Shift Vectors, not original coordinates';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.searchdist_m
    IS 'The maximum length of the shift vector';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.plusconstant
    IS 'The workhorse deletes shift vectors using a number of iterations, plus a constant (in metres). This is done as there is nearly always valid shif vectors whose length is greater the 3 or even 4 standard deviations';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.snaptolm
    IS '???';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.svrid
    IS 'This is the Shift Vector Request Id, a sequentially assigned number';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.geom_orig
    IS 'This is the perimeter geometry of the CSB, TWA, PAA or plan the work flow is to run within';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_planlabel
    IS 'This is the plan label to be used in the processing, if needed';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_ipaddr
    IS 'This is the IP Address of the database where the source landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_dbname
    IS 'This is the Datebase Name of the database where the source landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_username
    IS 'This is the User name to log into the database where the source landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_password
    IS 'This is the Password to log into the database where the source landbase  theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_port
    IS 'This is the Port Number of the database where the source landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_themename
    IS 'This is the Theme Name (my_landbase) of the database where the source landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_uidfield
    IS 'This is the Field Name of the Unique Identifier of the source landbase theme - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_paaid
    IS 'This is the PAA Id to be processed - OR - ';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.source_csbid
    IS 'This is the CSB to be processed';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_ipaddr
    IS 'This is the IP Address of the database where the destination landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_dbname
    IS 'This is the Datebase Name of the database where the destination landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_username
    IS 'This is the User name to log into the database where the destination landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_password
    IS 'This is the Password to log into the database where the destinationlandbase  theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_port
    IS 'This is the Port Number of the database where the destination landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_themename
    IS 'This is the Theme Name (my_landbase) of the database where the destination landbase theme can be fould - the Shifting Cadastre problem';

COMMENT ON COLUMN xxSchemaxx.stt_shift_vect_request.destination_uidfield
    IS 'This is the Field Name of the Unique Identifier of the destination landbase theme - the Shifting Cadastre problem';
