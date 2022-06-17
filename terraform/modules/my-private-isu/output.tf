output "game_public_ip" {
  value = aws_spot_instance_request.game.*.public_ip
}

output "game_instance_id" {
  value = data.aws_instance.game.*.id
}

output "bench_public_ip" {
  value = aws_spot_instance_request.bench.*.public_ip
}

output "bench_instance_id" {
  value = data.aws_instance.bench.*.id
}
