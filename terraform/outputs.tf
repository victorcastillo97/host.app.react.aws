output "id_bucket" {
    description = "name of the bucket" 
    value = aws_s3_bucket.bucket.id
}