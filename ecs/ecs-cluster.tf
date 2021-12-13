resource "aws_ecs_cluster" "pagar_me" {
  name = "pagar-me-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}