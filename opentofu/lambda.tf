data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir = "./lambda"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = "template_aws_lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.11"

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
}

## MAPPING FOR KINESIS
# resource "aws_lambda_event_source_mapping" "example" {
#   event_source_arn  = var.example_kinesis_arn
#   function_name     = aws_lambda_function.test_lambda.arn
#   starting_position = "TRIM_HORIZON"
# }

## MAPPING FOR SQS
# resource "aws_lambda_event_source_mapping" "example" {
#   event_source_arn = aws_sqs_queue.sqs_queue_test.arn
#   function_name    = aws_lambda_function.example.arn
# }