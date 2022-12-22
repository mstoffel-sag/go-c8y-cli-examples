#!/bin/sh
c8y events list --includeAll --type 'c8y_StartProduction' | c8y events delete -f
c8y events list --includeAll --type 'c8y_StopProduction' | c8y events delete -f
c8y events list --includeAll --type 'c8y_PartOk' | c8y events delete -f
c8y events list --includeAll --type 'c8y_PartNOk' | c8y events delete -f