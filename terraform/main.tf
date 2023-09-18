
provider "aws" {
      region = "us-west-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"

  tags = {
    Name        = "${var.bucket_name}"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = false
  ignore_public_acls  = true
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "allow_access_from_all" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
    effect    = "Allow"
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
}
