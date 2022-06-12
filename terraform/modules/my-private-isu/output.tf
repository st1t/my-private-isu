output "game_01_public_ip" {
  value = aws_instance.game-01.public_ip
}

output "game_01_instance_id" {
  value = aws_instance.game-01.id
}

output "bench_01_public_ip" {
  value = aws_instance.bench-01.public_ip
}

output "bench_01_instance_id" {
  value = aws_instance.bench-01.id
}
