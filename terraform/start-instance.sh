#!/bin/bash

instance_id=$(terraform output -json | jq -r '.ec2_01_instance_id.value')
aws ec2 start-instances --instance-ids "$instance_id" >/dev/null 2>&1
echo "EC2インスタンスを起動中..."
#aws ec2 wait instance-status-ok --instance-ids "$instance_id"
sleep 5
IP=$(aws ec2 describe-instances | jq '.Reservations[].Instances[]|select(.ImageId == "ami-024cfcacc753fa53e" and .State.Name == "running" )|.PublicIpAddress')

echo "EC2 instance IP: $IP"
