# EFS MODULE 

module "efs" {
  source = "cloudposse/efs/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"

  namespace             = var.app_name
  stage                 = "test"
  name                  = var.vpc_namespace
  region                = var.region
  vpc_id                = module.vpc_main.vpc_id
  subnets               = module.vpc_main.private_subnets
  encrypted             = true
  create_security_group = true
  allowed_cidr_blocks   = [var.vpc_cidr]
  // associated_security_group_ids = [module.mount_target_security_group.security_group_id]

  access_points = {
    "mnt/efs" = {
      posix_user = {
        gid            = "1001"
        uid            = "5000"
        secondary_gids = "1002,1003"
      }
      creation_info = {
        gid         = "1001"
        uid         = "5000"
        permissions = "0755"
      }
    }
  }
}
