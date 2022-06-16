output "game_01_public_ip" {
  value = aws_spot_instance_request.game.*.public_ip
}

output "game_01_instance_id" {
  value = data.aws_instance.game.*.id
}

output "bench_01_public_ip" {
  value = aws_spot_instance_request.bench.*.public_ip
}

output "bench_01_instance_id" {
  value = data.aws_instance.bench.*.id
}
