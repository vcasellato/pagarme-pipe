resource "aws_codebuild_project" "codebuild_project_terraform_plan" {
  name          = local.codebuild_project_terraform_plan_name
  description   = "Terraform codebuild project"
  build_timeout = "100"
  service_role  = local.service_role

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = local.s3_logging_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "1.0.0"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${local.s3_logging_bucket}/${local.codebuild_project_terraform_plan_name}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_codebuild_project" "codebuild_project_terraform_apply" {
  name          = local.codebuild_project_terraform_apply_name
  description   = "Terraform codebuild project"
  build_timeout = "100"
  service_role  = local.service_role

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = local.s3_logging_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.12.16"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${local.s3_logging_bucket}/${local.codebuild_project_terraform_apply_name}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_apply.yml"
  }

  tags = {
    Terraform = "true"
  }
}