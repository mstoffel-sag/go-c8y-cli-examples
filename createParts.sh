#!/bin/sh
c8y events list --type 'c8y_StartProduction' | c8y events delete -f
c8y events list --type 'c8y_StopProduction' | c8y events delete -f