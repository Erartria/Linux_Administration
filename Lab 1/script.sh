#!/bin/sh

rm -rf ~/test
rm -rf ~/man.dir
rm ~/list1
rm ~/list_conf
rm ~/list_d
rm ~/list_conf_d
rm ~/man.txt

mkdir ~/test
cd ~/test
ls -a -p /etc > list
find /etc -type d | wc -l >> list
find /etc -type f -name ".*" | wc -l >> list
mkdir ~/test/links
ln list links/list_hlink
ln -s ~/test/list links/list_slink
ls -li -U links/list_hlink list links/list_slink | awk '{print $10 " : " $3}'
cat list | wc -l >> links/list_hlink
cmp links/list_hlink links/list_slink && echo "Yes" || "No"
mv list list1
cmp links/list_hlink links/list_slink && echo "Yes" || "No"
ln links/list_hlink ~/list1
find /etc -type f -name "*.conf" > ~/list_conf
find /etc -type d -name "*.d" > ~/list_d
cat ~/list_conf > ~/list_conf_d
cat ~/list_d >> ~/list_conf_d
mkdir ~/test/.sub
cp ~/list_conf_d ~/test/.sub/
cp -b ~/list_conf_d ~/test/.sub/
ls -a -R
man man > ~/man.txt
split -b 1K ~/man.txt
mkdir ~/man.dir
mv x* ~/man.dir
cd ~/man.dir
cat x* > man.txt
cmp ~/man.txt man.txt && echo "Yes" || "No"
echo "lul correcting man" > ~/man.buff
cat ~/man.txt >> ~/man.buff
echo "that was the last word about man" >> ~/man.buff
cat ~/man.buff > ~/man.txt
rm ~/man.buff
diff -u ~/man.txt ~/man.dir/man.txt > ~/man.diff
mv ~/man.diff ~/man.dir
cd ~/man.dir
patch man.txt < man.diff
cmp man.txt ~/man.txt && echo "Yes" || "No"