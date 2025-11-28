variable "prefix" {
  description = "Prefix for network resources (env included)"
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

variable "address_space" {
  description = "VNet CIDR"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet definitions (aks, db, ingress)"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
