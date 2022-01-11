#generic input varaible
variable "business_division" {
  description = "Business Division name"
  type        = string #list #numeric
  default     = "sap"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "resource_group_name" {
  type    = string
  default = "rg-default"
}

variable "resource_group_location" {
  type    = string
  default = "eastus"
}


