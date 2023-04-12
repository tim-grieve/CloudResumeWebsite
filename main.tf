terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-crc-frontend"
    key = "terraform.tfstate"
    region = "ca-central-1" 
  }
}

provider "aws" {
  region = var.provider_region_id
}

module "S3" {
  source = "./S3"

  s3_bucket_name        = var.s3_bucket_name
  s3_tag_name           = var.s3_tag_name
  s3_tag_value          = var.s3_tag_value
  s3_bucket_access      = var.s3_bucket_access
  s3_policy_type        = var.s3_policy_type
  s3_content_type       = var.s3_content_type
  s3_iam_policy_actions = var.s3_iam_policy_actions
  cloudfront_oid_arn    = module.CloudFront.cloudfront_origin_access_id
}

module "CloudFront" {
  source = "./CloudFront"

  cloudfront_originid                            = var.cloudfront_originid
  cloudfront_distribution_comment                = var.cloudfront_distribution_comment
  cloudfront_default_root_object                 = var.cloudfront_default_root_object
  cloudfront_oid_comment                         = var.cloudfront_oid_comment
  cloudfront_cache_forwarded_values_query_string = var.cloudfront_cache_forwarded_values_query_string
  cloudfront_cache_cookies                       = var.cloudfront_cache_cookies
  cloudfront_viewer_protocol_policy1             = var.cloudfront_viewer_protocol_policy1
  cloudfront_viewer_protocol_policy2             = var.cloudfront_viewer_protocol_policy2
  cloudfront_cache_behavior_path_pattern1        = var.cloudfront_cache_behavior_path_pattern1
  cloudfront_cache_behavior_path_pattern2        = var.cloudfront_cache_behavior_path_pattern2
  cloudfront_cache_behavior_methods_1            = var.cloudfront_cache_behavior_methods_1
  cloudfront_cache_behavior_methods_2            = var.cloudfront_cache_behavior_methods_2
  cloudfront_cache_behavior_methods_3            = var.cloudfront_cache_behavior_methods_3
  cloudfront_forwarded_values_headers            = var.cloudfront_forwarded_values_headers
  cloudfront_price_class                         = var.cloudfront_price_class
  cloudfront_georestriction_type                 = var.cloudfront_georestriction_type
  cloudfront_georestriction_locations            = var.cloudfront_georestriction_locations
  cloudfront_tag1_name                           = var.cloudfront_tag1_name
  cloudfront_tag1_value                          = var.cloudfront_tag1_value
  cloudfront_default_certificate                 = var.cloudfront_default_certificate
  cloudfront_compress                            = var.cloudfront_compress
  cloudfront_enabled                             = var.cloudfront_enabled
  cloudfront_default_ttl_1                       = var.cloudfront_default_ttl_1
  cloudfront_default_ttl_2                       = var.cloudfront_default_ttl_2
  cloudfront_ipv6_enabled                        = var.cloudfront_ipv6_enabled
  cloudfront_max_ttl_1                           = var.cloudfront_max_ttl_1
  cloudfront_max_ttl_2                           = var.cloudfront_max_ttl_2
  cloudfront_min_ttl                             = var.cloudfront_min_ttl

  s3_bucket_regional_domain_name = module.S3.s3_bucket_regional_domain_name
}