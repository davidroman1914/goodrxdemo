variable "AWS_ACCESS_KEY" {
  type    = "string"
  default = ""
}

variable "AWS_SECRET_KEY" {
  type    = "string"
  default = ""
}

variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "keys/goodrx"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "keys/goodrx.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
