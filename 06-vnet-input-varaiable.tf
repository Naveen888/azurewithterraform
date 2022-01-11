variable "vnet_name" {
  type    = string
  default = "vnet-default"
}
variable "vnet_address_sapce" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
#websaubent and name
variable "web_subnet_name" {
  type    = string
  default = "websubnet"
}

variable "web_subnet_adress" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
#appsubnet and name
variable "app_subnet_name" {
  type    = string
  default = "appsubnet"
}

variable "app_subnet_adress" {
  type    = list(string)
  default = ["10.0.11.0/24"]
}

#dbsubnet and name
variable "db_subnet_name" {
  type    = string
  default = "dbsubnet"
}

variable "db_subnet_adress" {
  type    = list(string)
  default = ["10.0.21.0/24"]
}

#bastion subnet and name

variable "bastion_subnet_name" {
  type    = string
  default = "bastionsubnet"
}

variable "bastion_subnet_adress" {
  type    = list(string)
  default = ["10.0.100.0/24"]
}


