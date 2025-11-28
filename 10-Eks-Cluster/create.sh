#!/bin/bash
#eksctl create cluster --name demo-cluster --region us-west-2 --node-type t3.micro --nodes 2
eksctl create cluster -f ./create-eks.yaml --wait
if [ $? -eq 0 ]; then
    echo "EKS cluster created successfully."
    aws eks update-kubeconfig --region us-west-2 --name roboshop-eks-cluster
else
    echo "Failed to create EKS cluster."
fi