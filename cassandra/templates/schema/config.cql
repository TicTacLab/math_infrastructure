CONSISTENCY ALL;
TRUNCATE configuration;

INSERT INTO
       configuration (config)
VALUES
	('{"rest-port":3000,"session-ttl":900,"cache-on":{{cache_on|lower}}}');
