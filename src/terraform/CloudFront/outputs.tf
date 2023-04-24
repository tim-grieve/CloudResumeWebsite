output "cloudfront_origin_access_id" {
    value = aws_cloudfront_origin_access_identity.resume-oid.iam_arn
}