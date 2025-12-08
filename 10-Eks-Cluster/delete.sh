#!/bin/bash

CLUSTER_NAME="roboshop-eks-cluster"
NODEGROUP_STACK="eksctl-roboshop-eks-cluster-nodegroup-roboshop-dev-ng"
CLUSTER_STACK="eksctl-roboshop-eks-cluster-cluster"

echo "Starting decommission process for EKS cluster: $CLUSTER_NAME"
echo "---------------------------------------------------------"

# 1. Disable termination protection on the main EKS cluster stack
echo "Disabling termination protection on the main cluster stack ($CLUSTER_STACK)..."
aws cloudformation update-termination-protection \
    --stack-name "$CLUSTER_STACK" \
    --no-enable-termination-protection

# 2. Disable termination protection on the Node Group stack (Crucial for manual cleanup/unsticking)
echo "Disabling termination protection on the node group stack ($NODEGROUP_STACK)..."
aws cloudformation update-termination-protection \
    --stack-name "$NODEGROUP_STACK" \
    --no-enable-termination-protection

# 3. Delete the Node Groups
# This command finds and deletes ALL managed node groups in the cluster.
# It's safer than specifying a single node group name unless you have multiple.
echo "Deleting all managed node groups in the cluster..."
eksctl delete nodegroup --cluster="$CLUSTER_NAME" --all

# 4. Delete the Cluster
echo "Deleting the EKS control plane and cluster stack..."
eksctl delete cluster --name="$CLUSTER_NAME" --wait

echo "---------------------------------------------------------"
echo "EKS Cluster deletion process initiated. Monitor AWS CloudFormation console for final status."