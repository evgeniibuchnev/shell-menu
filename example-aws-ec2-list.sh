#!/bin/bash

# Query running EC2 instances and get their public hostnames

aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query 'Reservations[*].Instances[*].[PublicDnsName]' \
    --output text | tr '\t' '\n' | grep -v '^$'
