resource "aws_codepipeline" "tf_codepipeline" {
  name     = local.tf_codepipeline_name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = local.s3_logging_bucket
    type     = "S3"
  }


  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = local.repository_name
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Terraform_Plan"

    action {
      name            = "Terraform-Plan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        

        ProjectName = local.codebuild_project_terraform_plan_name
      }
    }
  }

  stage {
    name = "Manual_Approval"

    action {
      name     = "Manual-Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "Terraform_Apply"

    action {
      name            = "Terraform-Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        
        ProjectName = local.codebuild_project_terraform_apply_name
      }
    }
  }
}