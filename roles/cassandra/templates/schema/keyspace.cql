CONSISTENCY ALL;

CREATE KEYSPACE IF NOT EXISTS malt
WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'DC01' : {{cassandra_replication_factor}}, 'DC02' : {{cassandra_replication_factor}}};

ALTER KEYSPACE system_auth
WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'DC01' : {{groups.cass_dc01|length}}, 'DC02' : {{groups.cass_dc02|length}};

USE malt;
