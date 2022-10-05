output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "alb_target_group_arn" {
  value = module.alb.alb_target_group_arn
}

output "alb_grupo_blanco_id" {
  value = module.alb.alb_target_group_id // just to compare with above output
}


// OUTPUTS FROM RDS MODULE 
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds.db_instance_id
}

// OUTPUTS FROM MODULE FARGATE

output "log-group-path" {
  value = module.fargate.aws-log-group-path
}


// OUTPUTS FROM EFS MODULE 

output "access_point_ids" {
  value = module.efs.access_point_ids
}

output "efs_id" {
  value = module.efs.id
}
