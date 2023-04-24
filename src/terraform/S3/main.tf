#S3 Bucket to host static resume website
resource "aws_s3_bucket" "resume_files" {
  bucket = var.s3_bucket_name

  tags = {
    "${var.s3_tag_name}" = "${var.s3_tag_value}"
  }
}

#Set S3 bucket access to private
resource "aws_s3_bucket_acl" "resume_files_acl" {
  bucket = aws_s3_bucket.resume_files.id
  acl = var.s3_bucket_access
}

#Block Public Access to the bucket
resource "aws_s3_bucket_public_access_block" "resume_bucket_public_access_block" {
  bucket = aws_s3_bucket.resume_files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#Update S3 bucket policy with Origin Access ID
data "aws_iam_policy_document" "resume_s3_policy" {
  statement {
    actions   = var.s3_iam_policy_actions
    resources = ["${aws_s3_bucket.resume_files.arn}/*"]

    principals {
      type        = var.s3_policy_type
      identifiers = [var.cloudfront_oid_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "resume_bucket_policy" {
  bucket = aws_s3_bucket.resume_files.id
  policy = data.aws_iam_policy_document.resume_s3_policy.json
}

#Load website files into S3 bucket.
resource "aws_s3_object" "website_files" {
  for_each = fileset("./src/Website/", "*")
  bucket = aws_s3_bucket.resume_files.id
  key = each.value
  source = "./src/Website/${each.value}"
  etag = filemd5("./src/Website/${each.value}")
  content_type = var.s3_content_type
}