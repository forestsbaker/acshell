#!bin/bash

function cpFile()
{
	sFile=$1
	if [ ! -e $sFile ]; then
        	return 0
        fi
	
	cpDir=$(dirname $2)
	mkdir -p $cpDir
	cp -f $1 $2
}

function bakFile()
{
	sFile=$1
	if [ ! -e $sFile ]; then
		return 0
	fi
	
	mkdir -p ${AcBackUpDir}	
	timeStamp=`date +%Y%m%d%H%M%S`
	fileDir=$(cd "$(dirname "$sFile")"; pwd)
	baseFile=`basename $sFile`
	oSFile=${fileDir}/${baseFile}#${timeStamp}
	oFileName=`echo "$oSFile" | sed 's/\//_/g'`
	oFile=${AcBackUpDir}/${oFileName}
	mv $sFile $oFile
}

function wgetSvn()
{
	if [ 2 -eq $# ];then
		wgetDir=$(dirname $2)
		mkdir -p $wgetDir
		wget "$1" --no-check-certificate -O $2
	fi
}

function checkRoot()
{
	[ `id -u` -ne '0' ] && echo 'must be root!' && exit
}

function getSystemId()
{
	isRedHat=$(lsb_release -i|grep "RedHatEnterpriseAS"|wc -l)
	if [ 1 -eq $isRedHat ]; then
		return 1
	fi
	
	isCentOS=$(lsb_release -i|grep "CentOS"|wc -l)
	if [ 1 -eq $isCentOS ]; then
                return 2
        fi
	
	return 0
}

function getSystemBit()
{
	sysBit=$(getconf LONG_BIT)	
	return $sysBit
}

function optService()
{
	SERVICE_NEED="apmd|atd|auditd|cpuspeed|crond|mdmonitor|mdmpd|microcode-ctl|network|ntpd|readahed_early|readahead_later|smartd|sshd|syslog|irqbalance"
	SERVICE_NONEED=`chkconfig --list|awk '{print $1}'|grep -vE $SERVICE_NEED`
	SERVICE_NEED_LIST=`echo $SERVICE_NEED|sed "s/|/ /g"`
	for i in $SERVICE_NONEED; 
	do 
		chkconfig --level 2345 $i off;
		service $i stop;
	done
	
	for i in $SERVICE_NEED_LIST;
	do 
		chkconfig --level 2345 $i on;
		service $i start;
	done
}

