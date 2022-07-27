variable "vpc_id" {
    description = "value"
    type = string
}

variable "ami" {
    description = "value"
    type = string
}

variable "instance_type" {
    description = "value"
    type = string
    default = "t2.micro"
}

variable "http_port" {
    description = "value"
    type = string
}

variable "ssh_port" {
    description = "value"
    type = string
}

variable "my_ip" {
    description = "value"
    type = string
}

variable "public_key" {
    description = "value"
    type = string
}

variable "connection_type" {
    description = "value"
    type = string
}

variable "ec2_user" {
    description = "value"
    type = string
}

variable "server_name" {
    description = "value"
    type = string
}

variable "sg_name" {
    description = "value"
    type = string
}

variable "env" {
    description = "value"
    type = string
}