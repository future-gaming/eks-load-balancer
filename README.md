<!-- BEGIN_TF_DOCS -->

## Terraform State Management Setup

Terraform backend for managing the state of Terraform configurations in a secure way using AWS S3 for state storage and AWS DynamoDB for state locking.

## Prerequisites

- AWS Account
- AWS CLI configured with administrative access
- Terraform installed on  local machine

## Directory Structure

Navigate to state resources directory
```sh
cd state_resources
```

## Configuration Files

This setup includes the following main resources:

- **AWS S3 Bucket**: Used for storing the Terraform state file.
- **S3 Bucket Public Access Block**: Configures the bucket to deny public access.
- **S3 Bucket Versioning**: Enables versioning to keep a history of state changes.
- **AWS DynamoDB Table**: Used for state locking to prevent concurrent execution conflicts.

## Steps to Deploy

### 1. Initialize Terraform

Initialize the Terraform environment to download the necessary providers and initialize the backend.

```sh
terraform init
```

### 2. Apply the Configuration

Apply the Terraform configuration to create the AWS resources. This step will create the S3 bucket for state storage and the DynamoDB table for state locking.

```sh
terraform apply
```


# Terraform AWS EKS Setup
Navigate to the main directory where the primary Terraform configuration files are located:

```sh
cd main_directory
```

## Configuration Overview

This setup includes:

- **AWS EKS Cluster**: EKS cluster along with the necessary configurations such as managed node groups and cluster addons.
- **AWS VPC**: Sets up a VPC configured with both public and private subnets to support the EKS cluster.
- **AWS ACM Certificate** SSL certificate for secure communications within cluster.
- **IAM Policy**: IAM policy for load balancer controller.
- **VPC Endpoint**: VPC interface endpoint for secure communication with VPC.


```sh
terraform init
```
```sh
terraform apply
```
## Load Balancer Controller Installation Steps

1. **Create an IAM service account for the controller:**

   Replace `<AWS_ACCOUNT_ID>` with your actual AWS Account ID.

   ```bash
   eksctl create iamserviceaccount \
     --cluster=eks-cluster \
     --namespace=kube-system \
     --name=aws-load-balancer-controller \
     --attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerPolicy \
     --override-existing-serviceaccounts \
     --region us-east-1 \
     --approve


2. **Add the EKS Helm chart repository:**

   ```bash 
   helm repo add eks https://aws.github.io/eks-charts

3. **Apply the required Custom Resource Definitions:**

   ```bash 
   kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

3. **Install the AWS Load Balancer Controller using Helm:**

   ```bash
   helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
   -n kube-system \
   --set clusterName=eks-cluster \
   --set serviceAccount.create=false \
   --set serviceAccount.name=aws-load-balancer-controller

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.54.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.eks_control_plane](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_worker_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.eks_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_dynamodb_table.terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.block_public_acls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_ip"></a> [local\_ip](#input\_local\_ip) | IP address for security group ingress rule | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | The name of the EKS Cluster |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |

<!-- END_TF_DOCS -->