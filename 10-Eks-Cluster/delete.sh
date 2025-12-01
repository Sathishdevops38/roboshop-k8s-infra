#!/bin/bash
eksctl delete nodegroup --cluster=roboshop-eks-cluster --all
eksctl delete cluster --name=roboshop-eks-cluster --wait
