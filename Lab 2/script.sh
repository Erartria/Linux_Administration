#1
DEF=''
fdisk /dev/sda << EOF
n
$DEF
$DEF
+300M
w
EOF

#2
blkid /dev/sda3 -o value -s PARTUUID > ~/sda3_uuid
cat ~/sda3_uuid

#3
mkfs.ext4 -b 4096 /dev/sda3

#4
dumpe2fs -h /dev/sda3

#5
tune2fs -i 2m -C 2 /dev/sda3

#6
mkdir /mnt/newdisk
mount -t ext4 /dev/sda3 mnt/newdisk

#7
ln -s /mnt/newdisk ~/link_newdisk
ls ~

#8
mkdir /mnt/newdisk/TEST_CATALOG
ls /mnt/newdisk

#9
cp /etc/fstab /fstab.backup
UUID=$(cat ~/sda3_uuid)
echo "UUID=$UUID /mnt/newdisk ext4 noexec,noatime 0 0" >> /etc/fstab
cat /etc/fstab

#10
DEF=''
fdisk /dev/sda << EOF
p
d
$DEF
n
$DEF
$DEF
$DEF
+350M
p
w
EOF
e2fsck -f /dev/sda3
reboot
resize2fs /dev/sda3

#11
fsck -n /dev/sda3

#12
DEF=''
fdisk /dev/sda << EOF
p
n
$DEF
$DEF
+12M
p
w
EOF
mkfs.ext4 dev/sda4
sudo tune2fs -J location=/dev/sda4 /dev/sda3

#13
DEF=''
fdisk /devs	 << EOF
p
n
$DEF
$DEF
+100M
n
$DEF
$DEF
+100M
p
w
EOF

#14
vgcreate vg1 /dev/sda5 /dev/sda6
lvcreate -L 50M -nlv01 vg1
mkdir /mnt/supernewdisk
mkfs.ext4 /dev/vg1/lv1
mount /dev/vg1/lv1 /mnt/supernewdisk

#15
mkdir /mnt/share
yum install samba
smbpasswd -a $USER {rootroot}
yum install cifs-utils
smbclient -U $USER \\\\192.168.1.36\\dir
mount -t cifs -o username=Everyone,password= //192.168.1.36/dir /mnt/share

#16
echo "//192.168.1.36/dir	/mnt/share	cifs	user=Everyone,password=,ro	0 0" >> /etc/fstab	



Защита:
Создать reid массив 10 симулировать сбой одного раздела, и восстановить
Каждый этап - скрин prod/mdstat