# TEST EFS FILE
# efs.tf file - creation of the efs, mount points, and access point
/* 
resource "aws_efs_file_system" "shared_efs" {
  creation_token = "${var.vpc_namespace}-efs"
  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
  tags = merge(
    {
      Name = "${var.vpc_namespace}-efs"
    },
    local.common_tags
  )
}

# Security Group of the efs mount targets
resource "aws_security_group" "shared_efs" {
  name        = "shared-efs-SG"
  description = "Allow EFS inbound traffic from VPC"
  vpc_id      = module.vpc_main.id

  ingress {
    description = "NFS traffic from VPC"
    protocol    = "tcp"
    from_port   = 2049
    to_port     = 2049
    cidr_blocks = [module.vpc_main.vpc_cidr]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 //  ELASTIC FILE SYSTEM MOUNT TARGET
resource "aws_efs_mount_target" "shared_efs" {
  count           = var.app_count
  file_system_id  = aws_efs_file_system.shared_efs.id
  subnet_id       = module.vpc_main.private_subnets
  security_groups = [aws_security_group.shared_efs.id]
}

resource "aws_efs_access_point" "shared_efs" {
  file_system_id = aws_efs_file_system.shared_efs.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/mnt/efs"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 755
    }
  }
  tags = merge(
    {
      Name = "${var.app_name}-ap"
    },
    local.common_tags
  )
} */


