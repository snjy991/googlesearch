########################################
########## OUTPUTS
########################################
# Outputs from this configuration.

# Change tracking
output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "caller_datetime" {
  value = timestamp()
}
