locals {
  repository_name                        = "Pagarme"
  region                                 = var.region
  build_name                             = "pagarme"
  service_role                           = aws_iam_role.codebuild.arn
  source_type                            = "CODECOMMIT"
  source_location                        = "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Pagarme"
  git_branch                             = "master"
  codebuild_project_terraform_plan_name  = "pagarme"
  codebuild_project_terraform_apply_name = "pagarme_apply"
  s3_logging_bucket                      = "pagarme-log-pipe1"
  tf_codepipeline_name                   = "pipeline-pagarme"
  pipe_name                              = "pagarme-pipe"


}