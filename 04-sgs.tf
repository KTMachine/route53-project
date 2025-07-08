# Security Group for ALB
resource "aws_security_group" "alb" {
  name = "alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Security Group for EC2 Instances
resource "aws_security_group" "ec2" {
  name = "ec2-sg"
  description = "Allow SSH, HTTP, and ICMP traffic to EC2 instances"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "ec2-sg"
  }
}


# Key Pair
resource "aws_key_pair" "deployer" {
  key_name = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}