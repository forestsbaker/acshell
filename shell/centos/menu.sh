#!bin/bash

#echo -n "please input your name:"
#read name
#echo "hello $name, welcome to IT website"

function showMainMenu()
{
clear
cat << END

---------------------------------------------------------
	1. yum 源管理与优化
	2. Web 服务
	3. Db 服务
	4. Ftp 服务
	5. Mail 服务
	6. Common 服务 
	7. CacheProxy 服务 
	8. HttpProxy 服务 
	9. 监控 服务 
	10. Search 服务 
	11. 安全 优化 
	12. 常用工具 优化
	13. 系统 优化
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
	elif [ 4 = $mId ]; then
		source ${AcCentosModDir}/ftp.sh
                showFtpMenu
	elif [ 00 = $mId ]; then
		exit
	else
		showMainMenu 1
	fi
}

