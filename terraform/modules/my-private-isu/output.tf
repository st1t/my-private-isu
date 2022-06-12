output "ec2_ip_01" {
  value = aws_instance.main-01.associate_public_ip_address
}