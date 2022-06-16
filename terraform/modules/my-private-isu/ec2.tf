data "aws_subnet" "main" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
  depends_on = [aws_subnet.main-public-a, aws_subnet.main-public-c, aws_subnet.main-public-d]
}

resource "aws_security_group" "main" {
  name        = "ec2-${var.app_name}"
  description = "ec2-${var.app_name}"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "my ip"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.my_ip]
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-${var.app_name}"
  }
}

resource "aws_key_pair" "main" {
  key_name   = var.app_name
  public_key = var.public_key
}

resource "aws_spot_instance_request" "game" {
  count                       = var.game_instance_count
  ami                         = var.game_instance_ami
  spot_price                  = var.game_spot_price
  spot_type                   = "persistent" # 停止できるようにpersistentにする
  instance_type               = var.game_instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  wait_for_fulfillment        = true
  user_data =<<EOF
#!/bin/bash
for user in ${var.github_users};
do
  curl https://github.com/$user.keys >> /home/${var.os_login_user}/.ssh/authorized_keys
done
EOF

  tags = {
    Name = "spot-${var.app_name}-game-${format("%02d",count.index + 1)}"
  }
}

data "aws_instance" "game" {
  count = var.game_instance_count
  filter {
    name   = "spot-instance-request-id"
    values = [aws_spot_instance_request.game[count.index].id]
  }
  depends_on = [aws_spot_instance_request.game]
}

resource "aws_ec2_tag" "game" {
  count       = var.game_instance_count
  resource_id = data.aws_instance.game[count.index].id
  key         = "Name"
  value       = "${var.app_name}-game-${format("%02d",count.index + 1)}"
  lifecycle {
    ignore_changes = [resource_id]
  }
}

resource "aws_spot_instance_request" "bench" {
  count                       = var.bench_instance_count
  ami                         = var.bench_instance_ami
  spot_price                  = var.bench_spot_price
  spot_type                   = "persistent" # 停止できるようにpersistentにする
  instance_type               = var.bench_instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  wait_for_fulfillment        = true
  user_data =<<EOF
#!/bin/bash
for user in ${var.github_users};
do
  curl https://github.com/$user.keys >> /home/${var.os_login_user}/.ssh/authorized_keys
done
EOF

  tags = {
    Name = "spot-${var.app_name}-bench-01"
  }
}

data "aws_instance" "bench" {
  count = var.bench_instance_count
  filter {
    name   = "spot-instance-request-id"
    values = [aws_spot_instance_request.bench[count.index].id]
  }
  depends_on = [aws_spot_instance_request.bench]
}

resource "aws_ec2_tag" "bench-01" {
  count       = var.bench_instance_count
  resource_id = data.aws_instance.bench[count.index].id
  key         = "Name"
  value       = "${var.app_name}-bench-01"
}
