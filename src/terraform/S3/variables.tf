variable "s3_bucket_name" {
    type = string
}

variable "s3_tag_name" {
    type = string
}

variable "s3_tag_value" {
    type = string
}

variable "s3_bucket_access" {
    type = string
}

variable "s3_policy_type" {
    type = string
}

variable "s3_content_type" {
    type = string
}

variable "s3_iam_policy_actions" {
    type = list
}

variable "cloudfront_oid_arn" {
    type = string
}
