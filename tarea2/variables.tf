variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "app_name" {
  description = "Name of the application"
  default     = "demo-app"
}

variable "container_image" {
  description = "Container image URI"
  default     = "296062576190.dkr.ecr.us-east-1.amazonaws.com/demo-app-gg"
}
