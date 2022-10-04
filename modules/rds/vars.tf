# VARIABLES FOR RDS MODULE

variable "vpc_namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = ""
  type        = string
}

variable "vpc_id" {
  description = "ID of the vpc"
}

variable "rds_port" {}


variable "vpc_cidr" {
  description = "CIDR of the vpc"
}

variable "db_name" {}

variable "db_password" {}

variable "db_username" {}

variable "db_subnet_group_name" {}

variable "private_subnets" {
  type        = list(string)
  description = "subnets for the rds subnet group"
}
