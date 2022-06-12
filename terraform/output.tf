output "ec2-01-public-ip" {
  value = module.my-private-isu.ec2_01_public_ip
}

output "ec2_01_instance_id" {
  value = module.my-private-isu.ec2_01_instance_id
}
