locals {
 
  region          = var.region
  env             = "dev"
  name =  "pagarme"
  cidr            = "172.30.248.0/22"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["172.30.248.0/25", "172.30.248.128/25", "172.30.249.0/25"]
  public_subnets  = ["172.30.249.128/25", "172.30.250.0/25", "172.30.250.128/25"]

  tags = {
    Env            = local.env
    
}
}