CONSISTENCY ALL;

CREATE KEYSPACE IF NOT EXISTS malt
WITH REPLICATION = {{ cassandra_malt_ks_replication_strategy|to_json|safe|replace("\"", "'") }};

ALTER KEYSPACE system_auth
WITH REPLICATION = {{ cassandra_system_ks_replication_strategy|to_json|safe|replace("\"", "'") }};

USE malt;