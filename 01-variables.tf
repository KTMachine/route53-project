variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.11.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type = list(string)
  default = ["10.11.1.0/24", "10.11.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type = list(string)
  default = ["10.11.11.0/24", "10.11.12.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type = string
}

variable "domain_name" {
  description = "Domain name for Route53"
  type = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 Instances"
  type = string
}

variable "asg_min_size" {
  description = "Minimum number of instances in ASG"
  type = number
  default = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in ASG"
  type = number
  default = 6
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in ASG"
  type = number
  default = 4
}

variable "ami_owners" {
  description = "Listof AMI owners for filter"
  type = list(string)
  default = ["amazon"]
}

variable "ami_name_pattern" {
  description = "Name pattern for AMI lookup"
  type = string
  default = "amzn2-ami-hvm-*-x86_64-gp2"
}