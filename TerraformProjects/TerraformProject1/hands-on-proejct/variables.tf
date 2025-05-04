variable "project_id" {
    description = "this is the google proejct ID "
    type = string
}

variable "region1" {
    description = "where you wanted to deploy your VM"
    type = string
    default = "us-central1"
}

variable "instance_name" {
    description = "this is the instance name"
    type = string
    default = "terraform-demo-vm"
}

variable "machine_type" {
    description = "what kind of image you wanted to add to this vm"
    type = string
    default = "e2-micro" 
}

variable "zone" {
    description = "In which zone we will deploy our app"
    type = string
    default = "us-central1-a"
}