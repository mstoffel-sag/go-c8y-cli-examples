#!/bin/bash

type=sts_demo

delete_devices() {
  c8y devices list --type=$type --includeAll | c8y devices delete -f
  rm -f devices.list
}

create_devices() {
  c8y util repeatfile devices.txt  | c8y devices create --type=$type -f --select id,name > "device.list"
}





delete_devices
sleep 3
create_devices 