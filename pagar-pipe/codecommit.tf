resource "aws_codecommit_repository" "pagarme_demo" {
  repository_name = local.repository_name
  description     = "Repo for pagarme"
}