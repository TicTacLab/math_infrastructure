-- CONSISTENCY ALL;
TRUNCATE settings;

INSERT INTO
       settings (settings)
VALUES
	('{"profiling-malt-host":"{{groups.malt_engine[0]}}","profiling-malt-port":"3000"}');
