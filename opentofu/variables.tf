variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "example_kinesis_arn" {
  description = "The ARN of the Kinesis stream to read events from"
  type        = string
}