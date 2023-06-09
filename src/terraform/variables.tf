variable "provider_region_id" {
  type    = string
  default = "ca-central-1"
}

variable "provider_us-east_1_region_id"{
  type = string
}

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
  type = list(any)
}

variable "cloudfront_originid" {
  type = string
}

variable "cloudfront_distribution_comment" {
  type = string
}

variable "cloudfront_default_root_object" {
  type = string
}

variable "cloudfront_oid_comment" {
  type = string
}

variable "cloudfront_cache_forwarded_values_query_string" {
  type = bool
}

variable "cloudfront_cache_cookies" {
  type = string
}

variable "cloudfront_viewer_protocol_policy1" {
  type = string
}

variable "cloudfront_viewer_protocol_policy2" {
  type = string
}

variable "cloudfront_cache_behavior_path_pattern1" {
  type = string
}

variable "cloudfront_cache_behavior_path_pattern2" {
  type = string
}

variable "cloudfront_cache_behavior_methods_1" {
  type = list(any)
}

variable "cloudfront_cache_behavior_methods_2" {
  type = list(any)
}

variable "cloudfront_cache_behavior_methods_3" {
  type = list(any)
}

variable "cloudfront_forwarded_values_headers" {
  type = string
}

variable "cloudfront_price_class" {
  type = string
}

variable "cloudfront_georestriction_type" {
  type = string
}

variable "cloudfront_georestriction_locations" {
  type = list(any)
}

variable "cloudfront_tag1_name" {
  type = string
}

variable "cloudfront_tag1_value" {
  type = string
}

variable "cloudfront_default_certificate" {
  type = bool
}

variable "cloudfront_enabled" {
  type = bool
}

variable "cloudfront_ipv6_enabled" {
  type = bool
}

variable "cloudfront_compress" {
  type = bool
}

variable "cloudfront_min_ttl" {
  type = number
}

variable "cloudfront_default_ttl_1" {
  type = number
}

variable "cloudfront_default_ttl_2" {
  type = number
}

variable "cloudfront_max_ttl_1" {
  type = number
}

variable "cloudfront_max_ttl_2" {
  type = number
}

variable "cloudfront_site_name" {
  type = string
}