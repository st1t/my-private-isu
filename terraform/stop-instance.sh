#!/bin/bash

aws ec2 stop-instances --instance-ids $(terraform output -json | jq -r '.ec2_01_instance_id.value')
