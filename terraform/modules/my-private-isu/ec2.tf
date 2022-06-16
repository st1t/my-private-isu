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

resource "aws_spot_instance_request" "game-01" {
  ami                         = "ami-0b37d5c92add6d0d5"
  spot_price                  = var.game_spot_price
  spot_type                   = "persistent" # 停止できるようにpersistentにする
  instance_type               = var.game_instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  wait_for_fulfillment = true

  tags = {
    Name = "spot-${var.app_name}-game-01"
  }
}

data "aws_instance" "game-01" {
  filter {
    name   = "spot-instance-request-id"
    values = [aws_spot_instance_request.game-01.id]
  }
  depends_on = [aws_spot_instance_request.game-01]
}

resource "aws_ec2_tag" "game-01" {
  resource_id = data.aws_instance.game-01.id
  key         = "Name"
  value       = "${var.app_name}-game-01"
}

resource "aws_spot_instance_request" "game-02" {
  ami                         = "ami-0b37d5c92add6d0d5"
  spot_price                  = var.game_spot_price
  spot_type                   = "persistent" # 停止できるようにpersistentにする
  instance_type               = var.game_instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  wait_for_fulfillment = true

  tags = {
    Name = "spot-${var.app_name}-game-02"
  }
}

data "aws_instance" "game-02" {
  filter {
    name   = "spot-instance-request-id"
    values = [aws_spot_instance_request.game-02.id]
  }
  depends_on = [aws_spot_instance_request.game-02]
}

resource "aws_ec2_tag" "game-02" {
  resource_id = data.aws_instance.game-02.id
  key         = "Name"
  value       = "${var.app_name}-game-02"
}

resource "aws_spot_instance_request" "game-03" {
  ami                         = "ami-0b37d5c92add6d0d5"
  spot_price                  = var.game_spot_price
  spot_type                   = "persistent" # 停止できるようにpersistentにする
  instance_type               = var.game_instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  wait_for_fulfillment = true

  tags = {
    Name = "spot-${var.app_name}-game-03"
  }
}

data "aws_instance" "game-03" {
  filter {
    name   = "spot-instance-request-id"
    values = [aws_spot_instance_request.game-03.id]
  }
  depends_on = [aws_spot_instance_request.game-03]
}

resource "aws_ec2_tag" "game-03" {
  resource_id = data.aws_instance.game-03.id
  key         = "Name"
  value       = "${var.app_name}-game-03"
}

resource "aws_spot_instance_request" "bench-01" {
  ami                         = "ami-024cfcacc753fa53e"
  spot_price                  = var.bench_spot_price
  spot_type                   = "persistent" # 停止できるようにpersistentにする
  instance_type               = var.bench_instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  wait_for_fulfillment = true

  tags = {
    Name = "spot-${var.app_name}-bench-01"
  }
}

data "aws_instance" "bench-01" {
  filter {
    name   = "spot-instance-request-id"
    values = [aws_spot_instance_request.bench-01.id]
  }
  depends_on = [aws_spot_instance_request.bench-01]
}

resource "aws_ec2_tag" "bench-01" {
  resource_id = data.aws_instance.bench-01.id
  key         = "Name"
  value       = "${var.app_name}-bench-01"
}
