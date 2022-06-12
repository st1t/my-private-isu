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
    self = true
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

resource "aws_instance" "game-01" {
  ami           = "ami-0b37d5c92add6d0d5"
  instance_type = var.game_instance_type

  subnet_id                   = aws_subnet.main-public-a.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  tags                        = {
    Name = "${var.app_name}-game-01"
  }
}

resource "aws_instance" "bench-01" {
  ami           = "ami-024cfcacc753fa53e"
  instance_type = var.bench_instance_type

  subnet_id                   = aws_subnet.main-public-a.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = var.app_name
  associate_public_ip_address = true
  tags                        = {
    Name = "${var.app_name}-bench-01"
  }
}
