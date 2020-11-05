#1
awk -F ':' '{print("user ", $1, " has id ", $3)}' /etc/passwd > work3.log
#2
chage -l root | head -n 1 | awk -F ':' '{print($1, $2)}' >> work3.log
#3
awk -F ':' 'ORS="," {print($1)}' /etc/group >> work3.log
#4
echo "Be careful!" > etc/skel/readme.txt
#5
useradd u1 -p $(openssl passwd -crypt 12345678)
#6
groupadd g1
#7
usermod -a -G g1 u1
#8
id u1 | awk -F ' ' '{print($1,$3)}' >> work3.log
#9
useradd user -p $(openssl passwd -crypt 12345678)
usermod -a -G g1 user
#10
awk -F ':' '$1 == "g1" {print($4)}' etc/group >> work3.log
#11
usermod --shell /usr/bin/mc u1
#12
useradd u2 -p $(openssl passwd -crypt 87654321)
#13
mkdir /home/test13
cp ~/scripts/lab3/work3.log /home/test13/work3-1.log
cp ~/scripts/lab3/work3.log /home/test13/work3-2.log
#14
usermod -a -G u1 u2
chown u1:u1 /home/test13 -R
chmod 640 /home/test13 -R
chmod 550 /home/test13
#15 sticky bit
mkdir /home/test14
chmod 1777 /home/test14
#16 setuid, setgid
cp /bin/nano /home/test14/nano
chmod 6555 /home/test14/nano
#17
mkdir /home/test15
echo "Secret file" > /home/test15/secret_file
chmod 444 /home/test15 -R
chmod 111 /home/test15/secret_file