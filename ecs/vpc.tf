module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"
  name    = local.name_vpc
  cidr    = local.cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = local.tags
}



