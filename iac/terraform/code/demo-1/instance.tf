resource "aws_instance" "ex1" {
    ami             = lookup(var.AMIS, var.AWS_REGION, "") # 마지막 파라미터는 default value
    instance_type   = "t2.micro"
}