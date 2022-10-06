#
# Terraform Provider(s) Variables
#
variable "master_id" {
  description = "The 12-digit account ID used for role assumption"
  default     = "<1234567890>"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "profile" {
  type    = string
  default = "default"
}

#
# KMS Variables
#
variable "kms_description" {
  description = "Unique identifier for this KMS key"
  default     = "Testing 1 KMS Key"
}

variable "key_usage" {
  description = "KMS key is either Symectric ot Asymetric"
  default     = "ENCRYPT_DECRYPT"
}

variable "deletion_window_in_days" {
  description = "Number of days for key deletion"
  default     = "7"
}

variable "is_enabled" {
  description = "Is this KMS key Enabled or Disabled"
  type        = bool
  default     = "true"
}

variable "key_rotation" {
  description = "Allow KMS to auto rotate the KMS Key"
  type        = bool
  default     = "true"
}

variable "kms_alias" {
  default = "alias/synergy-kms-key"
}

# KMS_RDS VARIABLES

variable "kms_rds_description" {
  description = "Unique identifier for this KMS key"
  default     = "Testing KMS RDS Key"
}

variable "kms_rds_alias" {
  default = "alias/synergy-kms-rds-key"
}

# KMS_ECS VARIABLES

variable "kms_ecs_description" {
  description = "Unique identifier for this KMS key"
  default     = "Testing KMS ECS Key"
}

variable "kms_ecs_alias" {
  default = "alias/synergy-kms-ecs-key"
}

# VPC VARIABLES

variable "vpc_namespace" {
  description = "The project namespace to use for unique resource naming"
  // default     = "wordpress-on-fargate"
  default = "wordpress-fargate"
  type    = string
}

variable "prefix" {
  default     = "wop"
  description = "Common prefix for AWS resources names"
}

variable "vpc_cidr" {
  description = "AWS VPC CIDR range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "The list of private subnets by AZ"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "public_subnets" {
  description = "The list of public subnets by AZ"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "enable_nat" {
  description = "To deploy or not to deploy a NAT Gateway"
  default     = "true"
}

variable "maduro_dickhead" {
  description = "Do you agree that Maduro is a dictator and should be removed from venezuelan government? More info: https://dictators-wiki.fandom.com/es/wiki/Nicol%C3%A1s_Maduro"
  type        = bool
  default     = true
}

# APPLICATION LOAD BALANCER VARIABLES

variable "app_port" {
  type        = number
  description = "app port for the alb"
  default     = 80
}

// variable for wordpress
/* variable "health_check_path" {
  default = "/index.php" # proper path for wordpress container
} */

variable "health_check_path" {
  default = "/" # proper path for nginx app container
}


##              RDS VARIABLES                 ##

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "wordpressRDS"
}

variable "db_password" {
  description = "DataBase Password"
  type        = string
  default     = "admin1234!"
}

variable "db_username" {
  description = "DataBase user name"
  type        = string
  default     = "admin"
}

variable "rds_port" {
  description = "DataBase security group port"
  default     = 3306
}

variable "db_subnet_group_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "wordpress_db_subnet_group"
}

# ECS FARGATE VARIABLES


variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_count" {
  type        = number
  description = "(total numbers of containers to be deployed"
  default     = 2
}

variable "app_name" {
  description = "Docker image to run in the ECS cluster"
  // default     = "wordpress-on-fargate"
  default = "wordpress-fargate"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  // default     = "wordpress"
  default = "wordpress"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

// EFS VARS

variable "volume_name" {
  type        = string
  description = "efs volume name"
  default     = "efs_volume"
}

