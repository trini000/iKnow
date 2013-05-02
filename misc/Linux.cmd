::::::	ProDRM
./LogViewer "-s2013-01-05 16:30:00" -e2013-01-06 -c2000 -aportal
tail -f /var/log/apache2/error_log
tail -f /usr/local/nginx/logs/error.log
./sendts -i 227.0.0.1 -p 27001 -c 2 -r 2500 -u /home/BTV-6.ts

./manager.sh start �Cc		rem ��
./manager.sh stop			rem	ͣ
rcapache2 restart			rem ����apache
rcsyslog restart			rem ��־���񡣴���/var/log/ProDRM.log

rem oracle
su oracle
cd /opt/oracle/product/11gR1/db/bin
./sqlplus system/system@icasdb
DRM���ݿ⣺icasplus/icas_passwd@icasdb
SMS��CMS���ݿ⣺minismscms/minismscms_pwd@icasdb

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

	rem backup - �޸�LogMConf.xml����Ҫ����LogManager
	::RSA, client side
	ssh-keygen -t rsa 
    cp /root/.ssh/id_rsa.pub -> /root./ssh/authorized_keys��
	
	::serverside
	scp �Cp .ssh/id_rsa.pub root@192.168.11.113:/root/.ssh/authorized_keys
    
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
::	init.ini�����SN, AI

pkill portal
kill -9 xxxxx
ps -ef |grep portal
ps aux |grep ./servicecontrol |wc -l


rem ����
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
rem ��װJDK
cp jdk-6u33-linux-x64.bin /usr/local
./jdk-6u33-linux-x64.bin

rem ��װApache-Tomcat
cp apache-tomcat-6.0.35.tar.gz /home
vi /home/apache-tomcat-6.0.35/bin/catalina.sh
	export JAVA_HOME=/usr/local/jdk1.6.0_33  (��tomcatָ��JDK��װ·��)
	export JAVA_OPTS="-Dwebapp=csip -Dfile.encoding=GBK -Xmx512m -Xms64m"
chmod +x /home/apache-tomcat-6.0.35/bin

cp MiniCMS.war /home/apache-tomcat-6.0.35/webapps
vi /home/apache-tomcat-6.0.35/webapps/MiniCMS/WEB-INF/classes/SysConfig.xml
/home/apache-tomcat-6.0.35/bin��/startup.sh	(/home/apache-tomcat-6.0.35/bin��/shutdown.sh)
tail -f /home/apache-tomcat-6.0.35/logs/catalina.out









. ~/.bashrc						rem ��ʾ����
uname							rem ϵͳ��Ϣ
su -c "commands"				rem SU
free							rem ϵͳ��Դ
top								rem top resource
find / -maxdepth 1 -name "@*" 	rem �����ļ�

/media
rpm -ivh xxxxx.rpm				rem ��װrpm
chmod +x FILE_NAME				rem	�޸�Ȩ��
ll -t | tac						rem sort by time, ascending
find / -maxdepth 1 -name "@*"	rem search







vi makefile					rem config file
make						rem	build makefile
make -f FILENAME

rem g++����.so�ļ�
::makefile, ����.a
{
	CPP=$(wildcard *.cpp)
	OBJS=$(CPP:cpp=o);
	INC=-I. -I../../include
	BIN=libconfigeditor.so

	$(BIN):$(OBJS)
		g++ -g -fPIC -shared -o $@ $^ -Wall $(INC)
	#	ar -r libConfig.a $(OBJS)
	#link: 					rem ����.so
		gcc -g main.c -lconfigeditor -L.

	%.o:%.cpp
		g++ -g -c -fPIC -o $@ $^ -Wall $(INC)

	clean:
		rm *.o a.out $(BIN)
}

rem ��Ĭ��path����.so����·��
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