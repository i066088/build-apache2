#!/bin/sh

#build on suse 11 SP3

zypper addrepo -G -k -f http://linuxinfra.wdf.sap.corp:1080/ldt/repos/updates/sles11.4/sles11-sdk-sp4-updates/ SLES_11_SP4_SDK_UPDATES
zypper addrepo -G -k -f http://linuxinfra.wdf.sap.corp:1080/ldt/repos/updates/sles11.4/sles11-sp4-updates/ SLES_11_SP4_UPDATES
zypper addrepo -G -k -f http://linuxinfra.wdf.sap.corp:1080/ldt/repos/updates/sles11.4/sles11-sp4-pool/ SLES_11_SP4_POOL
zypper addrepo -G -k -f http://linuxinfra.wdf.sap.corp:1080/ldt/repos/updates/sles11.4/sles11-sdk-sp4-pool/ SLES_11_SP4_SDK_POOL

zypper -n install --auto-agree-with-licenses libtool
zypper -n install --auto-agree-with-licenses pcre-devel
zypper -n install --auto-agree-with-licenses libexpat-devel  

mkdir /home/apache_build && cd /home/apache_build/

curl -O http://mirrors.tuna.tsinghua.edu.cn/apache//httpd/httpd-2.4.34.tar.gz
curl -O  http://mirrors.shu.edu.cn/apache//apr/apr-1.6.3.tar.gz
curl -O http://mirrors.shu.edu.cn/apache//apr/apr-util-1.6.1.tar.gz

tar xzvf apr-1.6.3.tar.gz
tar xzvf apr-util-1.6.1.tar.gz
tar xzvf httpd-2.4.34.tar.gz

cd apr-1.6.3 && ./configure && make && make install
cd ../apr-util-1.6.1 && ./configure --with-apr=/usr/local/apr && make && make install

cd ../httpd-2.4.34 && \
	./configure --with-apr=/usr/local/apr --enable-dialup --enable-reflector --enable-usertrack --enable-mime-magic --enable-log-forensic --enable-heartbeat --enable-heartmonitor --enable-dav-lock --enable-asis --enable-slotmem-plain --enable-proxy-fdpass --enable-data --enable-charset-lite --enable-echo --enable-watchdog --enable-mpms-shared="all" && \
	make && make install
	
