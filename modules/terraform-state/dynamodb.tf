resource "aws_dynamodb_table" "terraform_states_lock_table" {
  hash_key     = "LockID"
  name         = "terraform-states-lock-table"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_iam_policy_document" "allow_access_to_dynamodb" {
  statement {
    effect    = "Allow"
    resources = [aws_dynamodb_table.terraform_states_lock_table.arn]

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]
  }
}