sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
setenforce 0
iptables -F
amazon-linux-extras install epel -y
yum clean metadata
yum update
yum upgrade
amazon-linux-extras enable nginx1
yum install nginx
service firewalld stop
chkconfig firewalld off