provider "aws" {
  access_key = "ACCESS_KEY"
  secret_key = "SECRET_KEY"
  region     = "ap-northeast-2"
}

resource "aws_instance" "ec2-ex1" {
  ami           = "ami-035e3e44dc41db6a2"
  instance_type = "t2.micro"
}
