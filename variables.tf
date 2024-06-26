variable "local_ip" {
  description = "IP address for security group ingress rule"
  type        = string
}

variable "domain_name" {
  description = "Domain name for ACM Certificate"
  type        = string
}