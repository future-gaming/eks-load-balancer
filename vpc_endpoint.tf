resource "aws_vpc_endpoint" "eks_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.us-east-1.eks"
  vpc_endpoint_type = "Interface"
  subnet_ids        = module.vpc.private_subnets

  security_group_ids = [aws_security_group.eks_vpc_endpoint_sg.id]

  private_dns_enabled = true
}