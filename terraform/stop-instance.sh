#!/bin/bash

game_instance_id=$(terraform output -json | jq -r '.game_instance_id.value')
bench_instance_id=$(terraform output -json | jq -r '.bench_instance_id.value')

aws ec2 stop-instances --instance-ids "$game_instance_id" "$bench_instance_id" | cat
