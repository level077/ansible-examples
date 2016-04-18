#!/bin/sh
nohup {{ install_path }}/skydns/skydns -machines {{ machines }} -addr {{ ansible_ssh_host }}:53 -nameservers 223.5.5.5:53,223.6.6.6:53 -domain {{ domain }} & 
