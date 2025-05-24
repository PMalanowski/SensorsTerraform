resource "aws_s3_bucket" "sensor_data" {
  bucket = "iot-sensor-data-bucket-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_sqs_queue" "sensor_queue" {
  name = "sensor-data-queue"
}

resource "aws_lambda_function" "distributor" {
  function_name = "distributor"
  role          = var.lab_role_arn
  filename      = var.lambda_distributor_zip
  handler       = "distributor.lambda_handler"
  runtime       = "python3.9"
  timeout       = 30
  memory_size   = 128

  environment {
    variables = {
      S3_BUCKET_NAME  = aws_s3_bucket.sensor_data.bucket
      S3_FILE_NAME    = "sensor-1k.csv"
    }
  }
}

resource "aws_lambda_function" "processor" {
  function_name = "processor"
  role          = var.lab_role_arn
  filename      = var.lambda_processor_zip
  handler       = "processor.lambda_handler"
  runtime       = "python3.9"
  timeout       = 30
  memory_size   = 128
}
