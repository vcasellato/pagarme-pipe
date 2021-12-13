output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The vpc_id"
}

output "private_subnet_a" {
  value       = module.vpc.private_subnets[0]
  description = "Private subnet az a"
}

output "private_subnet_b" {
  value       = module.vpc.private_subnets[1]
  description = "Private subnet az b"
}

output "private_subnet_c" {
  value       = module.vpc.private_subnets[2]
  description = "Private subnet az c"
}

output "public_subnet_a" {
  value       = module.vpc.public_subnets[0]
  description = "Public subnet az a"
}

output "public_subnet_b" {
  value       = module.vpc.public_subnets[1]
  description = "Public subnet az b"
}

output "public_subnet_c" {
  value       = module.vpc.public_subnets[2]
  description = "Public subnet az c"
}
