########################################
########## VARIABLES
########################################
# Variables without a default value


variable "environment_id" {
  type        = string
  description = "The ID of the environment"
}


# Variables that have a default value.
variable "target_region" {
  type        = string
  description = "The AWS region where the terraform infra should be run"
  default     = "us-east-1"
}

variable "lambda_cloudwatch_logs_retention_days" {
  type        = number
  description = "The number of days which Lambda CloudWatch logs should be retained"
  default     = 60
}

variable "memory_size" {
  type    = number
  default = 512
}


variable "lambda_timeout_googleSearch" {
  type    = number
  default = 60
}

variable "subnet_ids" {
  type        = list(any)
  description = "Comma-separated list of subnet IDs for VPC"
  default     = []
}

variable "security_group_ids" {
  type        = list(any)
  description = "Comma-separated list of security group IDs for VPC"
  default     = []
}
