CONSISTENCY ALL;
CREATE KEYSPACE IF NOT EXISTS malt WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : {{cassandra_replication_factor}}};
ALTER KEYSPACE system_auth WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor': {{groups.tag_Cassandra_Yes|length}}};

USE malt;
