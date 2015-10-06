CONSISTENCY ALL;
TRUNCATE settings;

INSERT INTO
       settings (settings)
VALUES
	('{"profiling-malt-host":"{{groups.tag_Nginx_Yes[0]}}","profiling-malt-port":"80"}');
