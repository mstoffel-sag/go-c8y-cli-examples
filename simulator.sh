#!/bin/bash
type=sts_demo
send_measurements () {
    echo "Creating measurements"
    c8y util repeat --infinite |
    c8y devices list --type "$DEVICE_TYPE" --includeAll --delayBefore 10s |
    c8y measurements create --template ./values.jsonnet --select "source.id,**.value,**.unit" -f
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