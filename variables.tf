variable "region" {
  type = string
  default = "eu-west-2"
}
variable "create_s3" {
  type = bool
  default = false
}
variable "environment" {
  type = string
  default = ""  
}
variable "s3_name"{
  type = string
  default = ""
}
variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}
variable "create_block_public_access" {
  type = bool
  default = false
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




  

  
