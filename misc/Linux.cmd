::::::	ProDRM
./LogViewer "-s2013-01-05 16:30:00" -e2013-01-06 -c2000 -aportal
tail -f /var/log/apache2/error_log
tail -f /usr/local/nginx/logs/error.log
./sendts -i 227.0.0.1 -p 27001 -c 2 -r 2500 -u /home/BTV-6.ts

./manager.sh start –c		rem 启
./manager.sh stop			rem	停
rcapache2 restart			rem 重启apache
rcsyslog restart			rem 日志服务。创建/var/log/ProDRM.log

rem oracle
su oracle
cd /opt/oracle/product/11gR1/db/bin
./sqlplus system/system@icasdb
DRM数据库：icasplus/icas_passwd@icasdb
SMS和CMS数据库：minismscms/minismscms_pwd@icasdb

sqlplus  /nolog
conn /as sysdba
startup/shutdown immediate/abort
select table_name from user_tables
	:: DATE
	to_date('2013-1-25 16:00:00','yyyy-mm-dd hh24:mi:ss')

rem	log
cd /var/log
cat /dev/null  > ProDRM.log
ll

rem LogManager
\04.Src\lib\script\LogMConf.xml			rem LogManagerConf.sh
\04.Src\lib\script\LogXmlData.XML		rem LogAppConf.sh

	rem backup - 修改LogMConf.xml后需要重启LogManager
	::RSA, client side
	ssh-keygen -t rsa 
    cp /root/.ssh/id_rsa.pub -> /root./ssh/authorized_keys。
	
	::serverside
	scp –p .ssh/id_rsa.pub root@192.168.11.113:/root/.ssh/authorized_keys
    
	::testing
	scp -p text root@192.168.11.113:/root 
    ::text                 100% |**************************|    19       00:00

::daily
vi /etc/logrotate.d/ProDRMLog

rem ott
spawn-fcgi -a 127.0.0.1 -p 9005 -f ./ottepg.fcgi
/srv/www/htdocs/xxx										rem m3u8 location
http://192.168.200.65:8080/ottepg?cmd=getottxxx			rem visit content list
http://192.168.200.65/xxx/xxx-contentid.m3u8			rem visit m3u8

rem STB
::	init.ini里，设置SN, AI

pkill portal
kill -9 xxxxx
ps -ef |grep portal
ps aux |grep ./servicecontrol |wc -l


rem 主备
config.xml	--	groupid same, mode=1, DB same
manager.sh		-- use same MulticastIP,	MulticastSendIP unique, but on the same subnet
setup.xml	--	smp same group, 2 ips  - upload on pms
	rem TServer-w
	<DynamicIP_Terminal>192.168.200.209</DynamicIP_Terminal>
	<NICName_Terminal>eth6</NICName_Terminal>



rem PMS		http://<ip>/pms/							/home
./php_ext.sh
./pms.sh

rem SMS		http://<ip>/sms/src/index.php				/srv/www/htdocs
tar zxvf sms.tar.gz
vi /srv/www/htdocs/sms/wsdl/SOAPPortal.wsdl
vi /srv/www/htdocs/sms/public/BaseConfig.php
export LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib:$LD_LIBRARY_PATH

rem CMS		http://<ip>:8070/MiniCMS/pages/login.jsp		/home/apache-tomcat-6.0.35
rem 安装JDK
cp jdk-6u33-linux-x64.bin /usr/local
./jdk-6u33-linux-x64.bin

rem 安装Apache-Tomcat
cp apache-tomcat-6.0.35.tar.gz /home
vi /home/apache-tomcat-6.0.35/bin/catalina.sh
	export JAVA_HOME=/usr/local/jdk1.6.0_33  (将tomcat指向JDK安装路径)
	export JAVA_OPTS="-Dwebapp=csip -Dfile.encoding=GBK -Xmx512m -Xms64m"
chmod +x /home/apache-tomcat-6.0.35/bin

cp MiniCMS.war /home/apache-tomcat-6.0.35/webapps
vi /home/apache-tomcat-6.0.35/webapps/MiniCMS/WEB-INF/classes/SysConfig.xml
/home/apache-tomcat-6.0.35/bin下/startup.sh	(/home/apache-tomcat-6.0.35/bin下/shutdown.sh)
tail -f /home/apache-tomcat-6.0.35/logs/catalina.out









. ~/.bashrc						rem 显示中文
uname							rem 系统信息
su -c "commands"				rem SU
free							rem 系统资源
top								rem top resource
find / -maxdepth 1 -name "@*" 	rem 查找文件

/media
rpm -ivh xxxxx.rpm				rem 安装rpm
chmod +x FILE_NAME				rem	修改权限
ll -t | tac						rem sort by time, ascending
find / -maxdepth 1 -name "@*"	rem search







vi makefile					rem config file
make						rem	build makefile
make -f FILENAME

rem g++编译.so文件
::makefile, 生成.a
{
	CPP=$(wildcard *.cpp)
	OBJS=$(CPP:cpp=o);
	INC=-I. -I../../include
	BIN=libconfigeditor.so

	$(BIN):$(OBJS)
		g++ -g -fPIC -shared -o $@ $^ -Wall $(INC)
	#	ar -r libConfig.a $(OBJS)
	#link: 					rem 生成.so
		gcc -g main.c -lconfigeditor -L.

	%.o:%.cpp
		g++ -g -c -fPIC -o $@ $^ -Wall $(INC)

	clean:
		rm *.o a.out $(BIN)
}

rem 给默认path增加.so所在路径
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./

rem debug
gdb ./test.t








rem svn
svn add FILENAME/DIR
svn commit --message "message" --file --username USER --password PASS (svn ci -m "msg" -F)
svn update [PATH]













rcSuSEfirewall2 status
net statistics workstation

date						rem	datetime
date -s 12/09/99 
date -s 14:18:09












::	----------		cygwin		----------
cd /cygdrive/ 				rem parent path

nbtstat -A + ip
nslookup
shutdown -r -t 0			rem CMD restart