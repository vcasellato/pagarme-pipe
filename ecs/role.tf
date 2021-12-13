module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "4.1.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  role_name = "${local.prefix}-execution-role"

  create_role         = true
  attach_admin_policy = true
  role_requires_mfa   = false

  tags = local.tags
}
