resource "aws_ecs_task_definition" "task_pagarme" {
  family                   = local.prefix
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = local.cpu
  memory                   = local.memory

  task_role_arn      = module.iam_assumable_role.iam_role_arn
  execution_role_arn = module.iam_assumable_role.iam_role_arn

  container_definitions = jsonencode([
    {
      name   = local.prefix
      image  = "nginx"
      cpu    = local.cpu
      memory = local.memory
      portMappings = [
        {
          containerPort = local.container_port
          hostPort      = local.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = local.region
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-stream-prefix = aws_cloudwatch_log_group.this.name
        }
      }
    }
  ])


  tags = local.tags
}

resource "aws_ecs_service" "service_pagarme" {
  name             = local.prefix
  cluster          = aws_ecs_cluster.pagar_me.name
  task_definition  = aws_ecs_task_definition.task_pagarme.arn
  platform_version = "1.4.0"

  desired_count = local.desired_count

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  health_check_grace_period_seconds  = 5

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg_pagarme.id]
    subnets          = [module.vpc.private_subnets[2], module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.pagarme_teste_tg.arn
    container_name   = local.prefix
    container_port   = local.container_port
  }

  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 100
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${local.prefix}"
  retention_in_days = local.log_retention_in_days

  tags = local.tags
}
