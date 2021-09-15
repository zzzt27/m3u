#!/bin/bash
	
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi
	
	tsel='https://my.telkomsel.com/'
	xl='https://www.xl.co.id/'
	isat='https://indosatooredoo.com/'
	tri='https://tri.co.id/'
	smart='https://www.smartfren.com/'
	
function cek() {
if curl -X "HEAD" --connect-timeout 3 -so /dev/null "http://www.xl.co.id/"; then
	web=$xl
	update
	 echo "Success $xl"
		 elif curl -X "HEAD" --connect-timeout 3 -so /dev/null "http://my.telkomsel.com/"; then
	 web=$tsel
	 update
	 echo "Success $tsel"
	 	 elif curl -X "HEAD" --connect-timeout 3 -so /dev/null "http://indosatooredoo.com/"; then
	web=$isat
	update
	 echo "Success $isat"
	 	 elif curl -X "HEAD" --connect-timeout 3 -so /dev/null "http://tri.co.id/"; then
	 web=$tri
	 update
	 echo "Success $tri"
	 	 elif curl -X "HEAD" --connect-timeout 3 -so /dev/null "http://www.smartfren.com/"; then
	 web=$smart
	 update
	 echo "Success $smart"
else
	echo "error"
	error
fi
}

function error(){
    echo "error"
	sleep 10
	cek
}

function update() {
nistTime=$(curl --connect-timeout 2 -I --insecure $web | grep -i "date")
   #echo "sync time & $nistTime"
    dateString=$(echo $nistTime | cut -d' ' -f2-7)
    dayString=$(echo $nistTime | cut -d' ' -f2-2)
    dateValue=$(echo $nistTime | cut -d' ' -f3-3)
    monthValue=$(echo $nistTime | cut -d' ' -f4-4)
    yearValue=$(echo $nistTime | cut -d' ' -f5-5)
    timeValue=$(echo $nistTime | cut -d' ' -f6-6)
    timeZoneValue=$(echo $nistTime | cut -d' ' -f7-7)
    #echo $dateString
    case $monthValue in
        "Jan")
            monthValue="01"
            ;;
        "Feb")
            monthValue="02"
            ;;
        "Mar")
            monthValue="03"
            ;;
        "Apr")
            monthValue="04"
            ;;
        "May")
            monthValue="05"
            ;;
        "Jun")
            monthValue="06"
            ;;
        "Jul")
            monthValue="07"
            ;;
        "Aug")
            monthValue="08"
            ;;
        "Sep")
            monthValue="09"
            ;;
        "Oct")
            monthValue="10"
            ;;
        "Nov")
            monthValue="11"
            ;;
        "Dec")
            monthValue="12"
            ;;
        *)
            continue
    esac
	echo $yearValue.$monthValue.$dateValue-$timeValue
    date --utc --set $yearValue.$monthValue.$dateValue-$timeValue
	}
	
	
case "${1}" in
  *)
    cek
    ;;
  -u)
    update
    ;;
esac
