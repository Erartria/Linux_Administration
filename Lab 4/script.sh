#1
dnf groupinstall "Development Tools"

#2
mkdir bastet
cd bastet
sudo smbclient //DESKTOP-QGQEE8U/SharedCentos -U $USER
get bastet-0.43.tgz
q

tar -xzvf bastet-0.43.tgz
cd bastet-0.43/
yum install boost-devel
yum install ncurses-devel ncurses
make
./bastet
ctrl+Z

nano Makefile
install:
install ./bastet /usr/bin

make install
/usr/bin/bastet

#3
yum list installed > task3.log
less task3.log
#4
yum deplist gcc > task4_1.log
rpm -q —whatrequires libgcc > task4_2.log

#5
yum install createrepo
mkdir localrepo
cd localrepo
sudo smbclient //DESKTOP-QGQEE8U/SharedCentos -U $USER
get checkinstall-1.6.2-3.el6.1.x86_64.rpm
q

cd /etc/yum.repos.d

nano localrepo.repo

"[localrepo]
name=localrepo
baseurl=file:///root/localrepo
enabled=1
gpgcheck=0"

createrepo /root/localrepo
yum repolist all

#6
yum repolist all | grep 'enabled' > task6.log

#7
cd /etc/yum.repos.d/
for f in *; do mv "$f" "$(echo "$f" | sed s/\.repo/\.rep/)"; done
mv localrepo.rep localrepo.repo
yum list available
rpm -i checkinstall-1.6.2-3.el6.1.x86_64.rpm

#8
sudo smbclient //DESKTOP-QGQEE8U/SharedCentos -U $USER
get fortunes-ru_1.52-2_all.deb
quit

yum install wget
wget -O ~/alien.tar.xz https://sourceforge.net/projects/alien-pkg-convert/filse/latest/download
tar xf alien_8.95.tar.xz
yum install perl -y
cd alien-8.95
perl Makefile.PL; make; make install

cd ..
alien —r —scripts ./fortunes-ru_1.52-2_all.deb
rpm -i fortunes-ru_1.52-2_all.rpm

#9
dnf download nano

dnf install https://extras.getpagespeed.com/release-el8-latest.rpm
dnf install rpmrebuild	

rpmrebuild -enp nano-2.9.8-1.el8.x86_64.rpm
"Version: 2.9.8_newnano
...
%post
...
mv /usr/bin/nano /usr/bin/newnano
%preun
mv /usr/bin/newnano /usr/bin/nano"
cd rpmbuild/RPMS/x86_64/
yum remove nano
rpm -i nano-2.9.8_newnano-1.el8.x86_64.rpm