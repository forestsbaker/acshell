#!bin/bash

function isExistCmd()
{
        if which $1 2>/dev/null; then
                return 1
        else
                return 0
        fi
}

isExistCmd yum
isYumCmd=$?

if [ 0 -eq $isYumCmd ];then
	echo "no exist yum command";
#        exit 0
fi

# is exist lsb_release cmd 
isExistCmd lsb_release
isLsbCmd=$?

# install lsb_release
if [ 0 -eq $isLsbCmd ];then
	yum install redhat-lsb -y
fi

isExistCmd lsb_release
isLsbCmd=$?

if [ 0 -eq $isLsbCmd ];then
	echo "no exist lsb_release command";
	exit 0
fi

AcCentosDir="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
AcShellHome=$(dirname $AcCentosDir)
AcCentosModDir=${AcCentosDir}/mod
AcBackUpDir=${AcCentosDir}/data/bak

AcSystemName=$(lsb_release -i | cut -d ':' -f 2)
AcReleaseID=$(lsb_release -r | cut -d ':' -f 2)
AcRelVersion=${AcReleaseID%.*}
AcSystemBit=$(getconf LONG_BIT)

source ${AcCentosDir}/lib.sh
source ${AcCentosDir}/menu.sh

showMainMenu
