#linux vm input variable placeholder file
variable "web_vmss_nsg_inbound_ports" {
  description = "Web vmss nsg port"
  type        = list(string)
  default     = [22,80,443]
}