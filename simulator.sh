#!/bin/bash
type=sts_demo
batchId=2
device="FGL1 M1 1"
accountId="0016800000IYqNmAAL"
batchEventCount=20

send_measurements () {
    echo "Creating measurements"
    c8y util repeat --infinite | 
    c8y devices list --name "$device" --includeAll --delayBefore 3s |
    c8y measurements create --template ./values.jsonnet --select "source.id,batchId,**.value,**.unit" -f
}
send_events () {
    echo "Creating events"
    c8y devices list  --name "FGL1 M1 1" | c8y events create --type c8y_StartProduction  --text "Production started for Customer $accountId" --template "{c8y_SFAccountId:'$accountId'}" -f
    c8y util repeat $batchEventCount | 
    c8y devices list --name "$device" --delayBefore 3s | c8y events create  --templateVars "batchId=$batchId" --template ./event.jsonnet -f  
    c8y devices list  --name "FGL1 M1 1" | c8y events create --type c8y_StopProduction  --text "Production stopped for Customer $accountId" --template "{c8y_SFAccountId:'$accountId'}" -f
}




send_alarms () {
    echo "Send alarms"
    while true; do 
    c8y devices list --type $type --includeAll --cache --cacheTTL 10d --select id | c8y util repeat --randomSkip 0.9 --randomDelayMax 10s |
    c8y util repeat --infinite --randomSkip 0.5 --delay 10s |
    c8y alarms create --type "Bat_alarm" --severity "WARNING" --text "Emergency stop due to detected bats in park panel pressed in automatic mode." -f |    
    c8y alarms update --status ACKNOWLEDGED --delayBefore 60s  --select "source.id" -f |
    c8y alarms update --status CLEARED --delayBefore 120s  --select "source.id" -f 
    done
}

"$@"