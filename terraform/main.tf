provider "aws" {
  region = "ap-south-1"  # Update to your desired AWS region
}

# Reference default VPC
data "aws_vpc" "default" {
  default = true
}

# Reference public subnets in the default VPC
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Create IAM Role for the EKS cluster
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

# Create EKS Cluster using the default VPC and subnets
resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.default.ids
  }
}

# Output the kubeconfig for kubectl
output "kubeconfig" {
  value = aws_eks_cluster.eks_cluster.kubeconfig
}

