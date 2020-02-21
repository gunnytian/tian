TIME=60
SPEC_TIME=(07:30)
CHAT_ID=-396514054
TOKEN=927664773:AAETira7j7HuXIJK60ZN2cTMfPmCeNMHPCk
URL=`hostname`
IP=`curl ifconfig.me`
crit=50
while true
do
    queue=`ls -LR /opt/kerio/mailserver/store/queue | egrep *.env | wc -l`
    #queue=`shuf -i 50-150 -n 1`
    rnow=`date +"%H:%M"`
    for s_time in ${SPEC_TIME[*]}
    do
        if [[ $rnow == $s_time ]]; then 
            text="SPEC_TIME: Script still running '$URL' '$IP' "
            curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=${CHAT_ID}" --data-urlencode "text=${text}" "https://api.telegram.org/bot${TOKEN}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
        fi
    done 
    if [[ $queue -ge $crit ]]
    then
        text="Number queues server $URL $IP is $queue"
        curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=${CHAT_ID}" --data-urlencode "text=${text}" "https://api.telegram.org/bot${TOKEN}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
    fi
    sleep $TIME
done