output "game_01_public_ip" {
  value = aws_spot_instance_request.game-01.public_ip
}

output "game_01_instance_id" {
  value = data.aws_instance.game-01.id
}

output "game_02_public_ip" {
  value = aws_spot_instance_request.game-02.public_ip
}

output "game_02_instance_id" {
  value = data.aws_instance.game-02.id
}

output "game_03_public_ip" {
  value = aws_spot_instance_request.game-03.public_ip
}

output "game_03_instance_id" {
  value = data.aws_instance.game-03.id
}

output "bench_01_public_ip" {
  value = aws_spot_instance_request.bench-01.public_ip
}

output "bench_01_instance_id" {
  value = data.aws_instance.bench-01.id
}
