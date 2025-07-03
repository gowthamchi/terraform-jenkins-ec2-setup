provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_ec2" {
  ami                    = "ami-0e001c9271cf7f3b9"
  instance_type          = "t2.micro"
  key_name               = "jenkins1198"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data              = file("${path.module}/user_data.sh")
  tags = {
    Name = "Jenkins-Auto"
  }
}
