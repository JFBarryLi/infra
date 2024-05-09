resource "aws_dynamodb_table" "travel_log" {
  name         = "TravelLog"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "TripName"
  range_key = "Date"

  attribute {
    name = "TripName"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
}

resource "aws_dynamodb_table" "adventure_log" {
  name         = "AdventureLog"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "PK"
  range_key = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
}
