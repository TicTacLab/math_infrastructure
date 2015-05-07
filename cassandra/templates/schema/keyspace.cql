-- CONSISTENCY ALL;
CREATE KEYSPACE IF NOT EXISTS malt WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};
-- ALTER KEYSPACE system_auth WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor': {{groups.cassandra|length}}};

USE malt;
