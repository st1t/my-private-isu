#!/bin/bash -eu

game_instance_ids=$(terraform output -json | jq -r '.game_instance_id.value[]')
bench_instance_ids=$(terraform output -json | jq -r '.bench_instance_id.value[]')

aws ec2 stop-instances --instance-ids "$game_instance_ids" "$bench_instance_ids" | cat
