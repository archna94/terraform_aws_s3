resource "aws_s3_bucket" "default" {
  count = var.create_s3 ? 1 : 0
  bucket = "${var.environment}-${var.s3_name}"
  tags = merge({ "ResourceName" = var.s3_name }, var.tags)
}

resource "aws_s3_bucket_public_access_block" "default" {
  count = var.create_block_public_access ? 1 : 0
  bucket                  = aws_s3_bucket.default[0].id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls 
  restrict_public_buckets = var.restrict_public_buckets
}
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.default[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.s3_enable_encryption ? var.s3_kms_master_key_id : null
      sse_algorithm     = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_acl" "default" {
  count = var.create_canned_acl ? 1 : 0
  bucket = aws_s3_bucket.default[0].id
  acl    = var.canned_acl
}
resource "aws_s3_bucket_lifecycle_configuration" "default" {
  count = length(var.lifecycle_rules) == 0 ? 0 : 1
  bucket = aws_s3_bucket.default[0].id

  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      id     = rule.value.id
      status = rule.value.status

      dynamic "noncurrent_version_transition" {
        for_each = rule.value.noncurrent_version_transition

        content {
          noncurrent_days = noncurrent_version_transition.value.noncurrent_days
          storage_class   = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }
  
}

resource "aws_s3_bucket_versioning" "default" {
  count = var.versioning_enabled ? 1 : 0
  bucket = aws_s3_bucket.default[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_notification" "notification" {
  count = var.create_bucket_notification ? 1 : 0
  bucket = var.s3_bucket_id
  queue {
    queue_arn     = var.create_s3_sqs_notification ? var.queue_arn : 0
    events        = ["s3:ObjectCreated:*"]
  }
  topic {
    topic_arn     = var.create_s3_sns_notification ? var.sns_arn : 0
    events        = ["s3:ObjectCreated:*"]
  }
  lambda_function {
    lambda_function_arn = var.create_s3_lambda_notification ? var.lambda_arn : 0
    events              = ["s3:ObjectCreated:*"]
  }
}

  


