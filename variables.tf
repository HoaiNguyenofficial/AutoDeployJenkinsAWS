variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = "LL-TEST"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "jenkins_user_name" {
  description = "jenkins"
  default = "jenkins"
}

variable "jenkins_user_password" {
  description = "jenkins"
  default = "jenkins"
}