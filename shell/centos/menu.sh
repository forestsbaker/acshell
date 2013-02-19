#!bin/bash

#echo -n "please input your name:"
#read name
#echo "hello $name, welcome to IT website"

function showMainMenu()
{
clear
cat << END

---------------------------------------------------------
	1. 增加 yum 源 及升级常用软件
	00. 退出
---------------------------------------------------------
	author:anjoecai mail:anjoecai@gmail.com 
---------------------------------------------------------
END
	echo -n "请输入 数字序号（如1），进入相应的操作:"
	read mId

	if [ 1 = $mId ]; then
		source ${AcCentosModDir}/yum.sh
		showYumMenu
	elif [ 00 = $mId ]; then
		exit
	else
		showMainMenu 1
	fi
}

