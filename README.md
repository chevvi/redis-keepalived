## Simple setup using Keepalived for Redis HA ##

Uses redis-cli for failover.


In master, install redis, keepalived, clone and copy the files:

```
sudo cp ./config/redis.conf /etc/redis.conf
sudo cp /.config/keepalived.master /etc/keepalived/keepalived.conf

# Optional
sudo chown -R redis:redis /etc/redis.conf
sudo chmod -R 644 /etc/redis.conf
sudo chmod -R 644 /etc/keepalived/keepalived.conf

# Copy scripts
sudo mkdir -p /etc/keepalived/scripts
sudo cp ./scripts /etc/keepalived/scripts
sudo chmod -R +x /etc/keepalived/scripts

```


In slave, install redis and keepalive and copy configs:

```
sudo cp ./config/redis.conf /etc/redis.conf
sudo cp /.config/keepalived.slave /etc/keepalived/keepalived.conf

# Optional
sudo chown -R redis:redis /etc/redis.conf
sudo chmod -R 644 /etc/redis.conf
sudo chmod -R 644 /etc/keepalived/keepalived.conf

# Copy scripts
sudo mkdir -p /etc/keepalived/scripts
sudo cp ./scripts /etc/keepalived/scripts
sudo chmod -R +x /etc/keepalived/scripts

```

Start the server and check statuses.

Сonvenient to use:
watch bash redis_port_check.sh <IP> <PORT> ; echo $?
from your PC when you want to ckeck redis. 
How does ipvs work when real server is shutting down.
