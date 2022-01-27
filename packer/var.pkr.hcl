variable "Environment" {
  type    = string
  default = "prod"
}

variable "IMDSv2" {
  type    = string
  default = "false"
}

variable "Owner" {
  type    = string
  default = "dj.kim"
}

variable "ami_users" {
  default = []
}
//variable "kms_key_id" {}

variable "ami_description" {
  type    = string
  default = "devops ami"
}

variable "ami_name" {
  type    = string
  default = "devops-ami"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ssh_keypair_name" {
  type    = string
  default = "prod"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "ssh_timeout" {
  type = string
  default = "3m"
}

variable "Region" {
  type = string
  default = "ap-northeast-2"
}

variable "playbook_file" {
  type = string
  default = "playbook.yaml"
}

# environment
#variable "SG_ID" {
#  type    = string
#}
#
#variable "SUBNET_ID" {
#  type    = string
#}
