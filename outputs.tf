output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
  description = "The name of the EKS Cluster"
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.acm_cert.arn
  description = "The arn of the ACM Certificate"
}

