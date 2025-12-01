#!/bin/bash
aws cloudformation update-termination-protection \
    --stack-name eksctl-roboshop-eks-cluster-nodegroup-roboshop-dev-ng \
    --no-enable-termination-protection
aws cloudformation update-termination-protection \
    --stack-name eksctl-roboshop-eks-cluster-cluster \
    --no-enable-termination-protection    
eksctl delete nodegroup --cluster=roboshop-eks-cluster --all
eksctl delete cluster --name=roboshop-eks-cluster --wait
