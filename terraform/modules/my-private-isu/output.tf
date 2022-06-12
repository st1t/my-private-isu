output "ec2_01_public_ip" {
  value = aws_instance.main-01.public_ip
}