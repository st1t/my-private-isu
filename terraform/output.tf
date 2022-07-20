output "game_public_ip" {
  value = module.my-private-isu.game_public_ip
}

output "game_instance_id" {
  value = module.my-private-isu.game_instance_id
}

output "game_instance_ami" {
  value = local.game_instance_ami
}

output "bench_public_ip" {
  value = module.my-private-isu.bench_public_ip
}

output "bench_instance_id" {
  value = module.my-private-isu.bench_instance_id
}

output "bench_instance_ami" {
  value = local.bench_instance_ami
}
