data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {
  prefix   = var.prefix
  vpc_name = "${var.vpc_namespace}-mdl" # this variables is local.vpc_name
  vpc_cidr = var.vpc_cidr
  common_tags = {
    Environment = "dev"
    Project     = "${var.vpc_namespace}-with efs"
  }
}

module "kms" {
  source                  = "./modules/kms"
  master_id               = var.master_id
  kms_description         = var.kms_description
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  key_rotation            = var.key_rotation
  policy                  = data.aws_iam_policy_document.synergy_key_policy.json
  alias                   = var.kms_alias
}

module "kms_rds" {
  source                  = "./modules/kms"
  master_id               = var.master_id           // remains the same account
  kms_description         = var.kms_rds_description // t'is unique to this module
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  key_rotation            = var.key_rotation
  policy                  = data.aws_iam_policy_document.synergy_key_policy_ecs.json
  alias                   = var.kms_rds_alias
}


module "kms_ecs" {
  source                  = "./modules/kms"
  master_id               = var.master_id           // remains the same account
  kms_description         = var.kms_ecs_description // t'is unique to this module
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  key_rotation            = var.key_rotation
  policy                  = data.aws_iam_policy_document.synergy_key_policy_ecs.json
  alias                   = var.kms_ecs_alias
}

module "vpc_main" {
  source = "./modules/vpc"

  create_vpc                             = true
  maduro_dickhead                        = var.maduro_dickhead
  create_igw                             = true
  create_database_internet_gateway_route = true
  name                                   = local.vpc_name
  cidr                                   = var.vpc_cidr
  azs                                    = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets                        = var.private_subnets
  private_subnet_suffix                  = "private"
  public_subnets                         = var.public_subnets
  public_subnet_suffix                   = "public"
  map_public_ip_on_launch                = true

  enable_nat_gateway     = var.enable_nat
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []
  enable_dns_support             = true
  enable_dns_hostnames           = true

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = merge(
    {
      Owner = "synergydevops"
    },
    local.common_tags
  )

}

module "alb" {
  source = "./modules/alb"

  vpc_namespace     = var.vpc_namespace
  private_subnets   = module.vpc_main.private_subnets
  public_subnets    = module.vpc_main.public_subnets
  vpc_id            = module.vpc_main.vpc_id
  app_port          = var.app_port
  health_check_path = var.health_check_path

}

/* module "rds" {
  source = "./modules/rds"

  vpc_id               = module.vpc_main.vpc_id
  vpc_namespace        = var.vpc_namespace
  rds_port             = var.rds_port
  vpc_cidr             = var.vpc_cidr
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  db_subnet_group_name = var.db_subnet_group_name
  private_subnets      = module.vpc_main.private_subnets
} */

module "fargate" {
  source     = "./modules/fargate"
  depends_on = [module.alb]

  region                = var.region
  vpc_id                = module.vpc_main.vpc_id
  app_name              = var.app_name
  app_image             = var.app_image
  app_port              = var.app_port
  fargate_memory        = var.fargate_memory
  fargate_cpu           = var.fargate_cpu
  app_count             = var.app_count
  az_count              = var.app_count
  private_subnets       = module.vpc_main.private_subnets
  public_subnets        = module.vpc_main.public_subnets
  alb_security_group_id = [module.alb.alb_security_group_id]
  alb_target_group_arn  = module.alb.alb_target_group_arn
}
