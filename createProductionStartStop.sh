#!/bin/bash

device="FGL1 M1 1"
accountId="0016800000IYqNmAAL"
batchId='1'
timeframe=120
prodperiod=10
c8y devices list  --name "FGL1 M1 1" | c8y events create --type c8y_StartProduction --time -${timeframe}m --text "Production started" --template "{c8y_SFAccountId:'$accountId'}" -f
c8y devices list  --name "FGL1 M1 1" | c8y events create --type c8y_StopProduction  --text "Production stopped" --template "{c8y_SFAccountId:'$accountId'}" -f

for i in $(seq 0 ${prodperiod} ${timeframe})
do
        c8y devices list  -n --name "$device" | c8y events create --time -${i}m  --templateVars "batchId=$batchId" --template ./event.jsonnet -f
done

