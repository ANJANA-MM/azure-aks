variable "prefix" {
  description = "Prefix for ACR name (env included)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "sku" {
  description = "ACR SKU tier"
  type        = string
  default     = "Premium"
}


