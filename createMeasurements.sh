#!/bin/bash

type=sts_demo

c8y devices list --type $type --includeAll |
c8y devices update --data 'c8y_RequiredAvailability={"responseInterval": 10}' -f | 
c8y devices update --template ./location.jsonnet -f