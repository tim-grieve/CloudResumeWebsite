terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.provider_region_id
}

#S3 Bucket to host static resume website
resource "aws_s3_bucket" "resume_bucket" {
  bucket = var.resume_bucket_name

  tags = {
    Name = "Bucket for cloud resume"
  }
}

#Set S3 bucket access to private
resource "aws_s3_bucket_acl" "resume_bucket_acl" {
  bucket = aws_s3_bucket.resume_bucket.id
  acl = "private"
}

#Block Public Access to the bucket
resource "aws_s3_bucket_public_access_block" "resume_bucket_public_access_block" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#Origin Access ID Resource to secure acess to only the cloud front distribution
resource "aws_cloudfront_origin_access_identity" "resume-oid" {
  comment = "Secured access to S3  bucket from cloudfront"
} 

#Cloudfront distribution using the resume bucket as the origin
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.resume_bucket.bucket_regional_domain_name
    origin_id                = var.originid

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.resume-oid.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.resume_distribution_comment
  default_root_object = "index.html"

  #logging_config {
  #  include_cookies = false
 #   bucket          = "mylogs.s3.amazonaws.com"
 #   prefix          = "myprefix"
 # }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.originid

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.originid

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.originid

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

#Update S3 bucket policy with Origin Access ID
data "aws_iam_policy_document" "resume_s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.resume_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.resume-oid.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "resume_bucket_policy" {
  bucket = aws_s3_bucket.resume_bucket.id
  policy = data.aws_iam_policy_document.resume_s3_policy.json
}

#Load website files into S3 bucket
resource "aws_s3_object" "website_files" {
  for_each = fileset("Website/", "*")
  bucket = aws_s3_bucket.resume_bucket.id
  key = each.value
  source = "Website/${each.value}"
  etag = filemd5("Website/${each.value}")
  content_type = "text/html"
}