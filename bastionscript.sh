#! /bin/bash
setenforce 0
grubby --update-kernel ALL --args selinux=0
echo -n 'Private Key Here' > /home/team4/.ssh/id_rsa
chmod 600 /home/team4/.ssh/id_rsa
chown team4:team4 /home/team4/.ssh/id_rsa
