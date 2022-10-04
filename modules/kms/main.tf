//
// AWS KMS Key for Cloudtrail encrypt_decrypt
//
resource "aws_kms_key" "synergy_key" {
  description             = var.kms_description
  key_usage               = var.key_usage
  policy                  = var.policy
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  enable_key_rotation     = var.key_rotation

  tags = {
    Description = "synergy-ETL-KMS"
    Environment = "Infrastructure-Services"
    ManagedBy   = "Terraform"
  }
}

//
// AWS KMS Key Alias
//
resource "aws_kms_alias" "synergy_key_alias" {
  name          = var.alias
  target_key_id = aws_kms_key.synergy_key.id
}
