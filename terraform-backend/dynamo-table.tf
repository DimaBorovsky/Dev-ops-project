resource "aws_dynamodb_table" "state-table" {
  name = "state-table"
  hash_key = aws_s3_bucket.tf-state-storage.id
  billing_mode = "PAY_PER_REQUEST"

}