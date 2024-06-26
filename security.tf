resource "aws_security_group" "eks_control_plane" {
  vpc_id = module.vpc.vpc_id
  description = "EKS Control Plane Security Group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-control-plane-sg"
  }
}

resource "aws_security_group" "eks_worker_nodes" {
  vpc_id = module.vpc.vpc_id
  description = "EKS Worker Nodes Security Group"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-worker-nodes-sg"
  }
}

resource "aws_security_group" "eks_vpc_endpoint_sg" {
  name        = "eks-vpc-endpoint-sg"
  description = "Security group for EKS VPC Endpoint"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTPS Inbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.local_ip]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EKS VPC Endpoint SG"
  }
}
