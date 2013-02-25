#!bin/bash

# 用户登录根目录
ftpUserHome=/usr/share/nginx/html/

# 用户名
ftpUserName=juna

# 用户ID
ftpUserId=498

# FTP 用户组
uFtpGroup=ftpuser

# FTP 用户组ID
uFtpGroupId=498

#创建组
#./ftpasswd --group --name=$uFtpGroup --file=/etc/ftpd.group --gid $uFtpGroupId --member $ftpUserName	

#创建用户
./ftpasswd --passwd --name=$ftpUserName --file=/etc/ftpd.passwd --uid=$ftpUserId --gid=$uFtpGroupId --home=$ftpUserHome --shell=/sbin/nologin

