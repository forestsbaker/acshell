#!bin/bash

function showFtpMenu()
{
clear
cat << END

Ftp 服务
---------------------------------------------------------
        0. 回到上级菜单
        1. 安装配置 proftpd
        00. 退出 
---------------------------------------------------------
        author:anjoecai mail:anjoecai@gmail.com 
---------------------------------------------------------
END
        echo -n "请输入 数字序号（如1），进入相应的操作:"
        read mId

        if [ 0 = $mId ]; then
                clear
                
		return
        elif [ 1 = $mId ]; then
        	yumInstallProFtpd
	elif [ 2 = $mId ]; then
        	yumInstallProFtpd
	elif [ 3 = $mId ]; then
		yumInstallProFtpd
        elif [ 4 = $mId ]; then
		yumInstallProFtpd
        elif [ 10 = $mId ]; then
		yumInstallProFtpd
        elif [ 11 = $mId ]; then
		yumInstallProFtpd
        elif [ 00 = $mId ]; then
                exit
        else
                showFtpMenu
                return
        fi
        showFtpMenu
}

function yumInstallProFtpd()
{
	yum -y install proftpd
	chkconfig --level 2345 proftpd on
}
