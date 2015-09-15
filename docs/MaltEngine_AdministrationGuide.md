# Malt Engine Administration Guide

DevOps guide. 

## Requirements

### Hardware

### Supported OS

### SSH configuratoin

```
$ cat .ssh/config

Host git.favorit
HostName 10.2.49.8
User gitolite

$ chmod 600 .ssh/config
 ```

## Instalation

### Configuration file

**Don't use config.example.json in production!**

All configuration settings are in malt_infrastructure project.

```
$ vim malt_infrastructure/group_vars/production_de.yml
```

Section *malt_engine_config*

```
malt_engine_config:
  "cache-on": true
  "port": 3000
  "host": "0.0.0.0"
  "session-ttl": 900
  "storage-keyspace": malt
  "storage-nodes": "{{groups.cassandra}}"
  "storage-password": "{{cassandra_password}}"
  "storage-user": malt
  "monitoring-hostname": "{{ansible_fqdn}}"
  "zabbix-host": "zp01internal.dc02.favorit"
  "zabbix-port": 10051
  "noilly-port": 1300

malt_engine_heap_size: '30g'
malt_engine_jmx_port: 7198

```


### Nginx configuration

## Update

### All hosts update

```
$ ansible-playbook -i production_de.hosts update_malt_engine.yml
```

### Some host update


```
$ ansible-playbook -i production_de.hosts --limit '10.2.49.43,10.2.49.44'  update_malt_engine.yml

```

### Update configuration on fly

```
$ http bla bla
```


## If something goes wrong


### Reset to older version

```
$ cd malt_infrastructure
$ git checkout a69a42d0a3cd3708a71a2d905a275c4329fee66d 

$ ansible-playbook -i production_de.hosts -e git_ref=ebdf5cfd02e66b391b4ed3e303282e747dd8bcf2 pre_malt_engine.yml update_malt_engine.yml

```
### Logs

```
$ tail -f /var/log/malt_engine/malt_engine.log

```

### Manual start/stop 
 
### JMX node monitoring
