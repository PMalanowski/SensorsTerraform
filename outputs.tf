output "s3_bucket_name" {
  value = aws_s3_bucket.sensor_data.bucket
}

output "sqs_queue_url" {
  value = aws_sqs_queue.sensor_queue.id
}

output "step_function_arn" {
  value = aws_sfn_state_machine.iot_state_machine.arn
}
