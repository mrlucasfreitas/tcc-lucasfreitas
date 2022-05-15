# Configuracoes de rede
vpc_id      = "vpc-afdeb8c8"
igw_name    = "igw-tcc"

route_name  = "rt-tcc"
route_cidr  = "0.0.0.0/0"

subnet_name = "sub-tcc"
subnet_cidr = "172.31.50.0/24"
subnet_az   = "us-east-1a"

# O security group libera a porta 80 para o mundo 
# e a porta 22 apenas para o IP publico da onde ele foi executado
sg_name     = "sec-tcc-webserver"

# Nome das instancias
num_of_instances = "1"
prefix_instance  = "ec2-tcc-webserver"
prefix_eip       = "eip-tcc-webserver"
prefix_interface = "eni-tcc-webserver"

# Configuracao das instancias
key_name          = "id_rsa_webserver"
ami               = "ami-0022f774911c1d690"
instance_type     = "t3.small"
availability_zone = "us-east-1a"
volume_size       = 8
volume_type       = "gp2"

# Tags
tags = {
  Managed = "terraform"
}