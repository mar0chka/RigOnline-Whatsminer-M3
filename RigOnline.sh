#!/bin/sh

#Rig number 1-150
rig= 
#Email
email=
#Secret key
secret=

echo "Timeout 30 sec..."
sleep 30

echo
echo START
echo ---------------------------
echo SEND RESTART TO RIGONLINE.RU ...
wget -q -T 10 -O - "https://rigonline.ru/api/?email=$email&secret=$secret&rig=$rig&restart=y" --no-check-certificate || echo ERROR

while true; do
if [ -f "/tmp/miner-state.log" ]; then
	CN="CN:$(ifconfig eth0| sed -n '2 {s/^.*inet addr:\([0-9.]*\) .*/\1/;p}'),"
	C="C:$(cat /var/miner-info),"
	LOGT="$(tail -n 50 /tmp/miner-state.log | grep -v "Machine freq" | tail -n 1 | sed s/\|/:/g)"
	UT="UT:$(uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {OFS=":";print d+0,h+0,m+0,"00"}'),"
	FAN_P=$(($(echo $LOGT | awk -F'(,|:)' '{if ($14<$15) {print $14} else {print $15}}')*100/6000))
	M="M:$(echo $LOGT | awk -F'(,|:)' '{OFS=""; print "FanIn-",$15,"_FanOut-",$14,"_SM0-",$2,"_SM1-",$6,"_SM2-",$10}'),"
	CPU="CT:0,CL:$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}'),"
	FAN="a0:F:C:$FAN_P,a1:F:C:$FAN_P,a2:F:C:$FAN_P,"
	DEVICE="G:a0:SM0,G:a1:SM1,G:a2:SM2,"
	SM="$(echo $LOGT | awk -F'(,|:)' '{OFS=""; print \
		"a0:C:C:",$3,",a0:C:L:",$2,"-GHS,a0:C:T:",$5,",a0:M:C:",$4,\
		",a1:C:C:",$7,",a1:C:L:",$6,"-GHS,a1:C:T:",$9,",a1:M:C:",$8,\
		",a2:C:C:",$11,",a2:C:L:",$10,"-GHS,a2:C:T:",$13,",a2:M:C:",$12,\
		","}')"
	HR_AVG="$(tail -n 50 /tmp/miner-state.log | grep -v "Machine freq" | sed s/\|/:/g | awk -F'(,|:)' 'BEGIN { coun=0; sum=0 } { coun++; sum+=$2+$6+$10 } END { print sum/coun }')"
	HR_RP="$(echo $LOGT | awk -F'(,|:)' '{print $2+$6+$10}')"
	HR="H1:btc_ghs_${HR_RP}_-_${HR_AVG}"
	result=$CPU$CN$UT$C$M$DEVICE$SM$FAN$HR
	
	echo
	#echo $result
	echo ---------------------------
	echo SEND DATA TO RIGONLINE.RU ...

	wget -q -T 10 -O - "https://rigonline.ru/api/?email=$email&secret=$secret&rig=$rig&gpu=$result" --no-check-certificate || echo ERROR
fi
	echo
	echo PAUSE 120
	sleep 120
done
