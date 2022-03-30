resource "aws_dynamodb_table" "travel_log" {
  name         = "TravelLog"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name      = var.state_bucket_name
    ManagedBy = "terraform"
  }
}
