#!bin/bash

AcYumList="yum-fastestmirror yum-priorities lsb_release zip unzip wget vim-enhanced at ntp sysstat vim-enhanced gcc gcc-c++ flex bison autoconf automake bzip2-devel ncurses-devel libjpeg-devel libpng-devel libtiff-devel freetype-devel pam-devel curl curl-devel patch make libtool gettext-devel mlocate zlib zlib-devel compat-libstdc* libxml2 libxml2-devel openssl-devel e2fsprogs-devel krb5-devel libidn-devel *g77 libmhash libmhash-devel irqbalance"

AcYumNginx="nginx"

AcYumMySql="mysql-server mysql"

AcYumPHP="php php-common php-mysql php-cli php-fpm php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-soap php-eaccelerator libxml2-devel libmcrypt libmcrypt-devel openssl-devel curl-devel libjpeg-devel libpng-devel freetype freetype-devel openldap-devel libmhash-devel mysql-devel libtool-ltdl libtool-ltdl-devel"

AcRpmForge32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/rpmforge/32/rpmforge.zip"
AcRpmForge64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/rpmforge/64/rpmforge.zip"

AcRepoEPEL4_32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/epel/4/32/epel.zip"
AcRepoEPEL4_64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/epel/4/64/epel.zip"

AcRepoEPEL5_32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/epel/5/32/epel.zip"
AcRepoEPEL5_64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/epel/5/64/epel.zip"

AcRepoEPEL6_32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/epel/6/32/epel.zip"
AcRepoEPEL6_64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/epel/6/64/epel.zip"

AcRepoRemi4_32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/remi/4/32/remi.zip"
AcRepoRemi4_64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/remi/4/64/remi.zip"

AcRepoRemi5_32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/remi/5/32/remi.zip"
AcRepoRemi5_64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/remi/5/64/remi.zip"

AcRepoRemi6_32="http://acshell.googlecode.com/svn/trunk/data/yum/repo/remi/6/32/remi.zip"
AcRepoRemi6_64="http://acshell.googlecode.com/svn/trunk/data/yum/repo/remi/6/64/remi.zip"

function showYumMenu()
{
clear
cat << END

 增加 yum 源 及升级常用软件
---------------------------------------------------------
	0. 回到上级菜单
        1. 添加 epel remi 源
	2. 添加 epel 源
	3. 添加 remi 源
	4. 添加 rpmforge 源
	10. 更新常用软件
	11. 安装 nginx php mysql
	00. 退出 
---------------------------------------------------------
        author:anjoecai mail:anjoecai@gmail.com 
---------------------------------------------------------
END
        echo -n "请输入 数字序号（如1），进入相应的操作:"
        read mId

        if [ 0 = $mId ]; then
                clear
		showMainMenu
		return
        elif [ 1 = $mId ]; then
                addRepoEPEL
		addRepoRemi
	elif [ 2 = $mId ]; then
		addRepoEPEL
	elif [ 3 = $mId ]; then
                addRepoRemi
	elif [ 4 = $mId ]; then
		addRepoRpmforge
        elif [ 10 = $mId ]; then
                yumUpdate
	elif [ 11 = $mId ]; then
                yumInstallNMP
	elif [ 00 = $mId ]; then
                exit
        else
                showYumMenu
		return
        fi
	showYumMenu
}

# update yum soft
function yumUpdate()
{
	yum -y update
	yum install -y $AcYumList
}

function yumInstallNMP()
{
	yum install -y --skip-broken $AcYumNginx
	yum install -y --skip-broken $AcYumMySql
	yum install -y --skip-broken $AcYumPHP
}

function addRepoRpmforge()
{
	# bak Files
	oPath=${AcCentosDir}/data/yum/repo/rpmforge/rpmforge.zip
	oDir=$(dirname $oPath)	
	bakFile $oDir
	mkdir -p $oDir 

	# download Files
	if [ 32 = $AcSystemBit ];then
		wgetSvn	$AcRpmForge32 $oPath
	elif [ 64 = $AcSystemBit ];then
		wgetSvn $AcRpmForge64 $oPath
	else
		echo "no support Rpmforge" 
	fi

	if [ ! -f $oPath ]; then
		return 0
	fi

	# bak repo
	repoFile=/etc/yum.repos.d/rpmforge.repo
	bakFile $repoFile
	 
	# install Rpm	
	unzip $oPath -d ${oDir}
	cd ${oDir}
	rpm --import *.txt
	rpm -ivh *.rpm
	cpFile ${oDir}/rpmforge.repo ${repoFile}
}

function addRepoRemi()
{
        # bak Files
        oPath=${AcCentosDir}/data/yum/repo/remi/remi.zip
        oDir=$(dirname $oPath)
        bakFile $oDir
        mkdir -p $oDir

        # download Files
        if [ 6 == $AcRelVersion ];then
                if [ 32 = $AcSystemBit ];then
                        wgetSvn $AcRepoRemi6_32 $oPath
                elif [ 64 = $AcSystemBit ];then
                        wgetSvn $AcRepoRemi6_64 $oPath
                else
                        echo "no support remi 6"
                fi
        elif [ 5 == $AcRelVersion ];then
                if [ 32 = $AcSystemBit ];then
                        wgetSvn $AcRepoRemi5_32 $oPath
                elif [ 64 = $AcSystemBit ];then
                        wgetSvn $AcRepoRemi5_64 $oPath
                else
                        echo "no support remi 5"
                fi
        elif [ 4 == $AcRelVersion ];then
                if [ 32 = $AcSystemBit ];then
                        wgetSvn $AcRepoRemi4_32 $oPath
                elif [ 64 = $AcSystemBit ];then
                        wgetSvn $AcRepoRemi4_64 $oPath
                else
                        echo "no support remi 4"
                fi
        else
                echo "no support this version"
        fi

        if [ ! -f $oPath ]; then
                return 0
        fi

        # bak repo
       	repoFile=/etc/yum.repos.d/remi.repo
        bakFile $repoFile

        # install Rpm   
        unzip $oPath -d ${oDir}
        cd ${oDir}
        rpm -ivh *.rpm
        rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
	cpFile ${oDir}/remi.repo ${repoFile}
}

function addRepoEPEL()
{
        # bak Files
        oPath=${AcCentosDir}/data/yum/repo/epel/epel.zip
        oDir=$(dirname $oPath)
        bakFile $oDir
        mkdir -p $oDir

        # download Files
	if [ 6 == $AcRelVersion ];then
		if [ 32 = $AcSystemBit ];then
                	wgetSvn $AcRepoEPEL6_32 $oPath
        	elif [ 64 = $AcSystemBit ];then
                	wgetSvn $AcRepoEPEL6_64 $oPath
        	else
			echo "no support epel 6"
		fi
	elif [ 5 == $AcRelVersion ];then
		if [ 32 = $AcSystemBit ];then
                        wgetSvn $AcRepoEPEL5_32 $oPath
                elif [ 64 = $AcSystemBit ];then
                        wgetSvn $AcRepoEPEL5_64 $oPath
                else
                        echo "no support epel 5"
                fi
	elif [ 4 == $AcRelVersion ];then
		if [ 32 = $AcSystemBit ];then
                        wgetSvn $AcRepoEPEL4_32 $oPath
                elif [ 64 = $AcSystemBit ];then
                        wgetSvn $AcRepoEPEL4_64 $oPath
                else
                        echo "no support epel 4"
                fi
	else
		echo "no support this version"
	fi

        if [ ! -f $oPath ]; then
                return 0
        fi

        # bak repo
        repoFile=/etc/yum.repos.d/epel.repo
        bakFile $repoFile

        # install Rpm   
        unzip $oPath  -d ${oDir}
        cd ${oDir}
        
	rpm -ivh *.rpm
	if [ 6 == $AcRelVersion ];then
		rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6	
	elif [ 5 == $AcRelVersion ];then
       		rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL 
	fi
	cpFile ${oDir}/epel.repo ${repoFile}
}
