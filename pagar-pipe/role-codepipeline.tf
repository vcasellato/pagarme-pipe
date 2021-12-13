resource "aws_iam_role" "codepipeline" {
  name = "${local.pipe_name}-CodePipelineRole"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["codepipeline.amazonaws.com","s3.amazonaws.com","codebuild.amazonaws.com","codecommit.amazonaws.com"]
                   
                    
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "codepipeline_policy" {
  name       = "${local.pipe_name}-PipelineAcess"
  roles      = [aws_iam_role.codepipeline.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}

resource "aws_iam_policy_attachment" "codepipeline_codecommit_policy" {
  name       = "${local.pipe_name}-PipelineAcess"
  roles      = [aws_iam_role.codepipeline.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}


resource "aws_iam_policy_attachment" "codepipeline_s3_policy" {
  name       = "${local.pipe_name}-PipelineAcess"
  roles      = [aws_iam_role.codepipeline.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}

resource "aws_iam_policy_attachment" "codepipeline_codebuild_policy" {
  name       = "${local.pipe_name}-PipelineAcess"
  roles      = [aws_iam_role.codepipeline.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}






