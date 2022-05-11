resource "aws_s3_bucket" "terraform_state" {
 bucket = "jakarta-terraform-state"
 acl    = "private"

 versioning {
   enabled = false
 }
}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform_state.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state" {
 name           = "terraform-state"
 billing_mode   = "PROVISIONED"
 read_capacity  = 1
 write_capacity = 1
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}