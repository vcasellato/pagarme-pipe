resource "aws_s3_bucket" "s3_logs" {
  bucket = local.s3_logging_bucket
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Logs        = "Logs for Codebuild"
  }
}