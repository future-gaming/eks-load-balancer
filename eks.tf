module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.30"

  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_private_access	= true


  cluster_additional_security_group_ids = [aws_security_group.eks_vpc_endpoint_sg.id]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
 }

  eks_managed_node_groups = {
    nodes = {
      instance_types = ["t3.large"]

      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }
}