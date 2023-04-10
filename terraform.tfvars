provider_region_id                             = "ca-central-1"
s3_bucket_name                                 = "tgrieve-resume-bucket"
s3_tag_name                                    = "Name"
s3_tag_value                                   = "Bucket for cloud resume"
s3_bucket_access                               = "private"
s3_policy_type                                 = "AWS"
s3_content_type                                = "text/html"
s3_iam_policy_actions                          = ["s3:GetObject"]
cloudfront_originid                            = "tgrieve-resume-origin-id"
cloudfront_distribution_comment                = "Secure front end to resume website"
cloudfront_default_root_object                 = "index.html"
cloudfront_oid_comment                         = "Secured access to S3 bucket from cloudfront"
cloudfront_cache_forwarded_values_query_string = false
cloudfront_cache_cookies                       = "none"
cloudfront_viewer_protocol_policy1             = "allow-all"
cloudfront_viewer_protocol_policy2             = "redirect-to-https"
cloudfront_cache_behavior_path_pattern1        = "/content/immutable/*"
cloudfront_cache_behavior_path_pattern2        = "/content/*"
cloudfront_cache_behavior_methods_1            = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
cloudfront_cache_behavior_methods_2            = ["GET", "HEAD", "OPTIONS"]
cloudfront_cache_behavior_methods_3            = ["GET", "HEAD"]
cloudfront_forwarded_values_headers            = "Origin"
cloudfront_price_class                         = "PriceClass_200"
cloudfront_georestriction_type                 = "whitelist"
cloudfront_georestriction_locations            = ["US", "CA"]
cloudfront_tag1_name                           = "Environment"
cloudfront_tag1_value                          = "Production"
cloudfront_default_certificate                 = true
cloudfront_enabled                             = true
cloudfront_ipv6_enabled                        = true
cloudfront_compress                            = true
cloudfront_min_ttl                             = 0
cloudfront_default_ttl_1                       = 3600
cloudfront_default_ttl_2                       = 86400
cloudfront_max_ttl_1                           = 86400
cloudfront_max_ttl_2                           = 31536000