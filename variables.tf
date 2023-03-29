variable "region" {
  type = string
  default = "eu-west-1"
}
variable "create_s3" {
  type = bool
  default = true
}
variable "environment" {
  type = string
  default = "dev"  
}
variable "s3_name"{
  type = string
  default = "kmnhgf"
}
variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}
variable "create_block_public_access" {
  type = bool
  default = true
}
variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}
variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}
variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}
variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}
variable "create_canned_acl" {
  description = "Whether to use a canned ACL."
  type        = bool
  default = true
}

variable "canned_acl" {
  description = "The canned ACL to apply to the bucket."
  type        = string
  default     = "private"

  validation {
    condition = contains([
      "private",
      "public-read",
      "public-read-write",
      "aws-exec-read",
      "authenticated-read",
      "bucket-owner-read",
      "bucket-owner-full-control",
      "log-delivery-write",
    ], var.canned_acl)

    error_message = "Canned ACL not one of the allowed types."
  }
}
variable "lifecycle_rules" {
  type = list(object({
    id     = string,
    status = string,

    noncurrent_version_transition = optional(list(object({
      noncurrent_days = number
      storage_class   = string
    })), [])
  }))

  default = []
}

variable "versioning_enabled" {
  description = "Whether versioning is enabled for bucket objects."
  type        = bool
  default     = false
}
variable "s3_enable_encryption" {
  description = "Determines whether encryption will be created (affects all resources)"
  type        = bool
  default     = false
}
variable "s3_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for s3"
  type        = string
  default = ""
}
variable "create_bucket_notification" {
  description = "Determines whether encryption will be created (affects all resources)"
  type        = bool
  default     = "false"
}

variable "s3_bucket_id" {
  description = "name of bucket id"
  type = string
  default = ""
}
variable "sqs_arn" {
  description = "arn of sqs service"
  type        = string
  default =  ""
}




  

  
