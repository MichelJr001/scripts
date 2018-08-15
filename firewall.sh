#!/bin/bash

# @author: Michel Anderson
# @github: MichelJr001
# @Twitter: _Michel_Jr_

# Limpar regras existentes

iptables -F
iptables -t nat -F
iptables -t mangle -F

# Evita DoS (Denial of Service)
echo 1 > /proc/sys/net/ipv4/tcp_syncookies # Ativa
# echo 0 > /proc/sys/net/ipv4/tcp_syncookies # Desativa

# Libera portas necessarias

iptables -A INPUT -p tcp --dport 22 -j ACCEPT # SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT # HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT # MYSQL
iptables -A INPUT -p ICMP -j DROP # PING
# Bloqueio de demais portar

iptables -A INPUT -p tcp --syn -j DROP
