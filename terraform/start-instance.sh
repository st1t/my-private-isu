#!/bin/bash -eu

game_instance_ids=$(terraform output -json | jq -r '.game_instance_id.value[]')
game_instance_ami=$(terraform output -json | jq -r '.game_instance_ami.value')
bench_instance_ids=$(terraform output -json | jq -r '.bench_instance_id.value[]')
bench_instance_ami=$(terraform output -json | jq -r '.bench_instance_ami.value')
tmp_file='.aws_ec2_describe_instances.log'

aws ec2 start-instances --instance-ids "$game_instance_ids" "$bench_instance_ids"
echo "EC2インスタンスを起動中..."
sleep 5
aws ec2 describe-instances >$tmp_file
game_ip=$(jq --arg ami "$game_instance_ami" '.Reservations[].Instances[]|select(.ImageId == $ami and .State.Name == "running" )|.PublicIpAddress' $tmp_file)
bench_ip=$(jq --arg ami "$bench_instance_ami" '.Reservations[].Instances[]|select(.ImageId == $ami and .State.Name == "running" )|.PublicIpAddress' $tmp_file)

echo "Game EC2 instance IP: $game_ip"
echo "Bench EC2 instance IP: $bench_ip"

rm -f $tmp_file
