required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
}
#Origin Access ID Resource to secure acess to only the cloud front distribution
resource "aws_cloudfront_origin_access_identity" "resume-oid" {
  comment = var.cloudfront_oid_comment
}

resource "aws_acm_certificate" "default" {
  provider = aws.aws_us_east_1

  domain_name = "${var.cloudfront_site_name}"

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

#Cloudfront distribution using the resume bucket as the origin
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = var.s3_bucket_regional_domain_name
    origin_id                = var.cloudfront_originid

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.resume-oid.cloudfront_access_identity_path
    }
  }

  enabled             = var.cloudfront_enabled
  is_ipv6_enabled     = var.cloudfront_ipv6_enabled
  comment             = var.cloudfront_distribution_comment
  default_root_object = var.cloudfront_default_root_object

  #logging_config {
  #  include_cookies = false
 #   bucket          = "mylogs.s3.amazonaws.com"
 #   prefix          = "myprefix"
 # }
  aliases = ["${var.cloudfront_site_name}"]

  default_cache_behavior {
    allowed_methods  = var.cloudfront_cache_behavior_methods_1
    cached_methods   = var.cloudfront_cache_behavior_methods_3
    target_origin_id = var.cloudfront_originid

    forwarded_values {
      query_string = var.cloudfront_cache_forwarded_values_query_string

      cookies {
        forward = var.cloudfront_cache_cookies
      }
    }

    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy1
    min_ttl                = var.cloudfront_min_ttl
    default_ttl            = var.cloudfront_default_ttl_1
    max_ttl                = var.cloudfront_max_ttl_1
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = var.cloudfront_cache_behavior_path_pattern1
    allowed_methods  = var.cloudfront_cache_behavior_methods_2
    cached_methods   = var.cloudfront_cache_behavior_methods_2
    target_origin_id = var.cloudfront_originid

    forwarded_values {
      query_string = var.cloudfront_cache_forwarded_values_query_string
      headers      = ["${var.cloudfront_forwarded_values_headers}"]

      cookies {
        forward = var.cloudfront_cache_cookies
      }
    }

    min_ttl                = var.cloudfront_min_ttl
    default_ttl            = var.cloudfront_default_ttl_2
    max_ttl                = var.cloudfront_max_ttl_2
    compress               = var.cloudfront_compress
    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy2
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = var.cloudfront_cache_behavior_path_pattern2
    allowed_methods  = var.cloudfront_cache_behavior_methods_2
    cached_methods   = var.cloudfront_cache_behavior_methods_3
    target_origin_id = var.cloudfront_originid

    forwarded_values {
      query_string = var.cloudfront_cache_forwarded_values_query_string

      cookies {
        forward = var.cloudfront_cache_cookies
      }
    }

    min_ttl                = var.cloudfront_min_ttl
    default_ttl            = var.cloudfront_default_ttl_1
    max_ttl                = var.cloudfront_max_ttl_1
    compress               = var.cloudfront_compress
    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy2
  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_georestriction_type
      locations        = var.cloudfront_georestriction_locations
    }
  }

  tags = {
    "${var.cloudfront_tag1_name}" = "${var.cloudfront_tag1_value}"
  }

  viewer_certificate {
    cloudfront_default_certificate = aws_acm_certificate.default.arn
  }
}