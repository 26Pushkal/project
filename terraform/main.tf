provider "aws" {
  region = "ap-south-1"  # Update to your desired AWS region
}

# Reference default VPC
data "aws_vpc" "default" {
  default = true
}

# Reference public subnets in the default VPC using filters
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



# Attach the AmazonEKSClusterPolicy managed policy
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Create EKS Cluster using the default VPC and subnets
resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
}

