# 12. 자원 정리


**EC2 Instance**

- worker 노드 제거
```shell
echo "Issuing shutdown to worker nodes.. " && \
aws ec2 terminate-instances \
  --instance-ids \
    $(aws ec2 describe-instances --filters \
      "Name=tag:Name,Values=worker-0,worker-1,worker-2" \
      "Name=instance-state-name,Values=running" \
      --output text --query 'Reservations[].Instances[].InstanceId')

echo "Waiting for worker nodes to finish terminating.. " && \
aws ec2 wait instance-terminated \
  --instance-ids \
    $(aws ec2 describe-instances \
      --filter "Name=tag:Name,Values=worker-0,worker-1,worker-2" \
      --output text --query 'Reservations[].Instances[].InstanceId')
```

- master 노드 제거
```shell
echo "Issuing shutdown to master nodes.. " && \
aws ec2 terminate-instances \
  --instance-ids \
    $(aws ec2 describe-instances --filter \
      "Name=tag:Name,Values=controller-0,controller-1,controller-2" \
      "Name=instance-state-name,Values=running" \
      --output text --query 'Reservations[].Instances[].InstanceId')

echo "Waiting for master nodes to finish terminating.. " && \
aws ec2 wait instance-terminated \
  --instance-ids \
    $(aws ec2 describe-instances \
      --filter "Name=tag:Name,Values=controller-0,controller-1,controller-2" \
      --output text --query 'Reservations[].Instances[].InstanceId')
```

- ssh key pair 제거
```shell
aws ec2 delete-key-pair --key-name kubernetes
```

**Networking**

- `Load Balancer`, `Security Group`, `Route Table`, `Internet Gateway`, `Subnet`, `VP`
- 로드밸런서 타입은 과금 대상
```shell
LOAD_BALANCER_ARN=$(aws elbv2 describe-load-balancers --names kubernetes --query 'LoadBalancers[*].[LoadBalancerArn]' --output text)
TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups --names kubernetes --query 'TargetGroups[*].TargetGroupArn' --output text)
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters 'Name=tag:Name,Values=kubernetes' --query 'SecurityGroups[*].[GroupId]' --output text)
ROUTE_TABLE_ID=$(aws ec2 describe-route-tables --output text --filters 'Name=tag:Name,Values=kubernetes' --query 'RouteTables[].Associations[].RouteTableId')
INTERNET_GATEWAY_ID=$(aws ec2 describe-internet-gateways --output text --filters 'Name=tag:Name,Values=kubernetes' --query 'InternetGateways[*].InternetGatewayId')
VPC_ID=$(aws ec2 describe-vpcs --output text --filters 'Name=tag:Name,Values=kubernetes-the-hard-way' --query 'Vpcs[*].VpcId')
SUBNET_ID=$(aws ec2 describe-subnets --output text --filters 'Name=tag:Name,Values=kubernetes' --query 'Subnets[*].SubnetId')

aws elbv2 delete-load-balancer --load-balancer-arn "${LOAD_BALANCER_ARN}"
aws elbv2 delete-target-group --target-group-arn "${TARGET_GROUP_ARN}"
aws ec2 delete-security-group --group-id "${SECURITY_GROUP_ID}"
ROUTE_TABLE_ASSOCIATION_ID="$(aws ec2 describe-route-tables \
  --route-table-ids "${ROUTE_TABLE_ID}" \
  --output text --query 'RouteTables[].Associations[].RouteTableAssociationId')"
aws ec2 disassociate-route-table --association-id "${ROUTE_TABLE_ASSOCIATION_ID}"
aws ec2 delete-route-table --route-table-id "${ROUTE_TABLE_ID}"
echo "Waiting a minute for all public address(es) to be unmapped.. " && sleep 60

aws ec2 detach-internet-gateway \
  --internet-gateway-id "${INTERNET_GATEWAY_ID}" \
  --vpc-id "${VPC_ID}"
aws ec2 delete-internet-gateway --internet-gateway-id "${INTERNET_GATEWAY_ID}"
aws ec2 delete-subnet --subnet-id "${SUBNET_ID}"
aws ec2 delete-vpc --vpc-id "${VPC_ID}"
```