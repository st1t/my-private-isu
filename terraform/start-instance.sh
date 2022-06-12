#!/bin/bash

game_instance_id=$(terraform output -json | jq -r '.game_01_instance_id.value')
bench_instance_id=$(terraform output -json | jq -r '.bench_01_instance_id.value')

aws ec2 start-instances --instance-ids "$game_instance_id $bench_instance_id" >/dev/null 2>&1
echo "EC2インスタンスを起動中..."
#aws ec2 wait instance-status-ok --instance-ids "$instance_id"
sleep 5
game_ip=$(aws ec2 describe-instances | jq '.Reservations[].Instances[]|select(.ImageId == "ami-0b37d5c92add6d0d5" and .State.Name == "running" )|.PublicIpAddress')
bench_ip=$(aws ec2 describe-instances | jq '.Reservations[].Instances[]|select(.ImageId == "ami-024cfcacc753fa53e" and .State.Name == "running" )|.PublicIpAddress')

echo "Game EC2 instance IP: $game_ip"
echo "Bench EC2 instance IP: $bench_ip"
