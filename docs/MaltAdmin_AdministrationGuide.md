# Malt Admin Administration Guide

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

Section *malt_admin_config*

```
malt_admin_config:
  "host": "0.0.0.0"
  "port": 8080
  "app-env": "production"
  "noilly-port": 1301
  "session-ttl": 3600
  "settings-table": "settings"
  "offload-repo": null
  "storage-keyspace": malt
  "storage-nodes": "{{groups.cassandra}}"
  "storage-password": "{{cassandra_password}}"
  "storage-user": malt
  "monitoring-hostname": "{{ansible_fqdn}}"
  "zabbix-host": "zp01internal.dc02.favorit"
  "zabbix-port": 10051

malt_admin_heap_size: '1g'

```

## Update

### All hosts update

```
$ ansible-playbook -i production_de.hosts update_malt_admin.yml
```

### Some host update

```
$ ansible-playbook -i production_de.hosts --limit '10.2.49.43,10.2.49.44'  update_malt_admin.yml
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

$ ansible-playbook -i production_de.hosts -e git_ref=ebdf5cfd02e66b391b4ed3e303282e747dd8bcf2 pre_malt_admin.yml update_malt_admin.yml

```

### Logs

```
$ tail -f /var/log/malt_admin/malt_admin.log

```

### Manual start/stop


### JMX node monitoring
