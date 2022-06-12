#!/bin/bash

aws ec2 stop-instances --instance-ids $(terraform output -json | jq -r '.game_01_instance_id.value')
aws ec2 stop-instances --instance-ids $(terraform output -json | jq -r '.bench_01_instance_id.value')
