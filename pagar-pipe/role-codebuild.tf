resource "aws_iam_role" "codebuild" {
  name = "${local.build_name}-CodebuildRole"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
        "codebuild.amazonaws.com",
        "codepipeline.amazonaws.com",
        "codecommit.amazonaws.com",
        "s3.amazonaws.com",
        "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "codebuild-policy" {
  name       = "${local.build_name}-CodeBuildFullAccess"
  roles      = [aws_iam_role.codebuild.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}



resource "aws_iam_policy_attachment" "codebuild_codecommit_policy" {
  name       = "${local.build_name}-CodeBuildFullAccess"
  roles      = [aws_iam_role.codebuild.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}

resource "aws_iam_policy_attachment" "cloudwatch-policy" {
  name       = "${local.build_name}-CloudWatchFullAccess"
  roles      = [aws_iam_role.codebuild.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}


resource "aws_iam_policy_attachment" "codepipeline_policy_codebuild" {
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


resource "aws_iam_policy_attachment" "codebuild_s3_policy" {
  name       = "${local.build_name}-PipelineAcess"
  roles      = [aws_iam_role.codebuild.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}


resource "aws_iam_policy_attachment" "ec2-policy" {
  name       = "${local.build_name}-Ec2FullAccess"
  roles      = [aws_iam_role.codebuild.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

  lifecycle {
    ignore_changes = [
      users,
      groups,
      roles,
    ]
  }
}


