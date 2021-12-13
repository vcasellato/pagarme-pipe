variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "commit_message" {
  description = "The commit_message"
  default     = ""
}

variable "environment_variables" {
  description = "The environment_variables"
  type        = list(any)
  default     = []
}
