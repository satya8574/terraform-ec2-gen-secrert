
# data "aws_subnet" "public-subnet" {
#   filter {
#     name   = "tag:Name"
#     values = [var.subnet_name]
#   }
# }

data "aws_vpc" "vpcfetch" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "terraform_remote_state" "subnet_ids" {
  backend = "s3"
  config = {
    bucket = "satya87456"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
# module "subnet_id" {
#   subnet_ids = data.terraform_remote_state.aws_subnet.mysubnet.id
# }
data "aws_subnet" "public-subnet" {
  filter {
    name   = "tag:Name"
    values = [data.terraform_remote_state.subnet_ids]
  }
}
