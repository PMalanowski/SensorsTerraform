variable "lab_role_arn" {
  type        = string
  description = "ARN roli LabRole przypisanej do Lambdy i Step Functions"
  default = "arn:aws:iam::832825130639:role/LabRole"
}

variable "lambda_distributor_zip" {
  default     = "./lambdas/distributor/distributor.zip"
  description = "Ścieżka do zipa z funkcją distributor"
}

variable "lambda_processor_zip" {
  default     = "./lambdas/processor/processor.zip"
  description = "Ścieżka do zipa z funkcją processor"
}
