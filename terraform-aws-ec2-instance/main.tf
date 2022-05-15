resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
    {
     "Name" = var.igw_name
    },
    var.tags
  )
}

resource "aws_route_table" "route" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    {
      "Name" = var.route_name
    },
    var.tags
  )
}

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_az

  tags = merge(
    {
      "Name" = var.subnet_name
    },
    var.tags
  )
}

resource "aws_route_table_association" "attach" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route.id
}

data "http" "myip" {
  url = "http://ifconfig.me/ip"
}

resource "aws_security_group" "allow_http" {

  vpc_id      = var.vpc_id
  name        = var.sg_name
  description = "Allow inbound traffic"

  ingress {
    description      = "SSH from specify ip"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
    ipv6_cidr_blocks = []
  }

  ingress {
    description      = "HTTP from all"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    {
      "Name" = var.sg_name
    },
    var.tags
  )
}

resource "aws_key_pair" "id_rsa" {
  key_name   = var.key_name
  public_key = file("key/${var.key_name}.pub")
}

resource "aws_network_interface" "interface" {
  count             = var.num_of_instances
  subnet_id         = aws_subnet.subnet.id
  security_groups   = [aws_security_group.allow_http.id]

  tags = merge(
    {
      "Name" = "${var.prefix_interface}-${count.index + 1}"
    },
    var.tags
  )
}

resource "aws_instance" "web" {
  count         = var.num_of_instances
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.id_rsa.key_name
  user_data     = file("data/so_update.sh")
  availability_zone = var.availability_zone

  network_interface {
    network_interface_id = aws_network_interface.interface[count.index].id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = merge(
    {
      "Name" = "${var.prefix_instance}-${count.index + 1}"
    },
    var.tags
  )
}

resource "aws_eip" "publicip" {
  count    = var.num_of_instances
  instance = aws_instance.web[count.index].id
  vpc      = true

  tags = merge(
    {
      "Name" = "${var.prefix_eip}-${count.index + 1}"
    },
    var.tags
  )
}

resource "time_sleep" "eip_propagation" {
  count    = var.num_of_instances
  create_duration = "10s"

  triggers = {
    subnet_id  = aws_eip.publicip[count.index].public_ip
  }
}