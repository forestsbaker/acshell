#!bin/bash

# 用户登录根目录
ftpUserHome=/data/test/

# 用户名
ftpUserName=anjoe

# 用户ID
ftpUserId=5000

# FTP 用户组
uFtpGroup=ftpuser

# FTP 用户组ID
uFtpGroupId=5000

#创建组
./ftpasswd --group --name $uFtpGroup --file /etc/ftpd.group --gid $uFtpGroupId --member $ftpUserName	

#创建用户
./ftpasswd --passwd --name $ftpUserName --file /etc/ftpd.passwd --uid $ftpUserId --gid $uFtpGroupId --home $ftpUserHome --shell /bin/false

