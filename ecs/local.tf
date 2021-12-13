locals {
  region = var.region

  name           = "pagarme-project"
  prefix         = "dev"
  container_port = 80
  cpu            = 512
  memory         = 1024

  
  desired_count = 1

  env             = "dev"
  name_vpc        = "pagarme"
  cidr            = "172.30.248.0/22"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["172.30.248.0/25", "172.30.248.128/25", "172.30.249.0/25"]
  public_subnets  = ["172.30.249.128/25", "172.30.250.0/25", "172.30.250.128/25"]




  log_retention_in_days = 7
  tags = {
    Env = "dev"

  }
}