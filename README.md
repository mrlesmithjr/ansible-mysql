Role Name
=========

An [Ansible] role to install/configure [MySQL]

- Configurable options and cacti monitoring ready.

Requirements
------------

None

Role Variables
--------------

```
---
# defaults file for ansible-mysql

# Defines if mysql should listen on loopback (default) or allow remove connections
mysql_allow_remote_connections: false

# Defines hosts where root can login from
mysql_allow_root_access_from_hosts:
  - '{{ ansible_hostname }}'
  - '127.0.0.1'
  - '::1'
  - 'localhost'
#  - '%'

# Defines cacti db password for monitoring (If Used)
mysql_cacti_db_password: 'cactiuser'

# Defines cacti db user for monitoring (If Used)
mysql_cacti_db_user: 'cactiuser'

# Defines fqdn of cacti server for monitoring (If Used)
mysql_cacti_server_fqdn: 'cacti.{{ mysql_pri_domain_name }}'

# Defines hostname of cacti server for monitoring (If Used)
mysql_cacti_server: 'cacti'

# Defines if replication should be configured
mysql_config_replication: false

# Defines if mysqlchk scripts should be configured for load balancer monitoring
mysql_config_mysqlchk: false

# Defines debian db password
# generate using echo password | mkpasswd -s -m sha-512
mysql_deb_db_password: '{{ mysql_root_password }}'

# Defines if cacti monitoring should be configured
mysql_enable_cacti_monitoring: false

# Defines the percentage of memory to use for memory calculations.
mysql_mem_multiplier: .25

# Defines the port for mysql to listen on
mysql_port: '3306'

mysql_replication_account_info:
  user: 'replicator'
  password: 'mysqlreplication'
mysql_replication_dbs:
  - 'test1'
  - 'test2'
mysql_replication_master_node: 'node0'
mysql_replication_nodes:
  - name: 'node0'
    role: 'master'
    server_id: '1'
  - name: 'node1'
    role: 'slave'
    server_id: '2'

# Defines mysql root password
# generate using echo password | mkpasswd -s -m sha-512
mysql_root_password: 'root'

mysql_settings:
  expire_logs_days: '10'
  #Default is 16M
  key_buffer_size: '{{ (ansible_memtotal_mb | int * mysql_mem_multiplier) | round | int }}M'
  max_allowed_packet: '16M'
  max_binlog_size: '100M'
  max_connections: '150'
  query_cache_limit: '1M'
  query_cache_size: '16M'
  thread_cache_size: '8'
  thread_stack: '192K'

# Defines the host to run mysqlchk against...usually localhost
mysql_mysqlchk_host: '127.0.0.1'

# Defines mysqlchk options to pass
mysql_mysqlchk_opts: '-N -q -A'

# Defines mysqlchk user
mysql_mysqlchk_user: 'cmon'

# Defines mysqlchk user password
mysql_mysqlchk_pass: 'cmon'

mysql_pri_domain_name: 'example.org'
```

Dependencies
------------

None

Example Playbook
----------------

```
---
- hosts: all
  become: true
  vars:
  roles:
    - role: ansible-mysql
  tasks:
```

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- @mrlesmithjr
- http://everythingshouldbevirtual.com
- mrlesmithjr [at] gmail.com

[Ansible]: <https://www.ansible.com>
[MySQL]: <https://www.mysql.com/>
