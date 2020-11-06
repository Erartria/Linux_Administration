#Дополнительное задание: создать нового пользователя без использования утилит useradd; adduser
#!/bin/bash
PASS=$(openssl passwd -crypt 12345678)
echo 'u3:x:1003:1004::/home/u3:/bin/bash' >> /etc/passwd
echo 'u3:x:1004:' >> /etc/group
echo 'u3:$PASS:18572:0:99999:7:::' >> /etc/shadow
mkdir /home/u3
touch /val/spool/mail/u3
chown u3:mail /var/spool/mail/u3
cp /etc/skel/* /home/u3 -rp
chown u3:u3 -R /home/u3