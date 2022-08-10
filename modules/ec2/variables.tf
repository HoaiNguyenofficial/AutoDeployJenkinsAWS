variable "namespace" {
  type = string
}

variable "vpc" {
  type = any
}

variable key_name {
  type = string
}

variable "sg_pub_id" {
  type = any
}

variable "sg_priv_id" {
  type = any
}

variable "jenkins_user_name" {
  description = "jenkins"
  default = "jenkins"
}

variable "jenkins_user_password" {
  description = "jenkins"
  default = "jenkins"
}