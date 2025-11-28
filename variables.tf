variable "environment" {
  description = "Environment name: dev, stage, prod"
  type        = string
}

#variable "location" {
# description = "Azure region, e.g. southeastasia"
# type        = string
#}

variable "prefix" {
  description = "Base name prefix, e.g. company or project"
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
}

variable "aad_admin_group_object_ids" {
  description = "AAD group object IDs that will be AKS admins"
  type        = list(string)
  default     = []
}

variable "api_server_authorized_ip_ranges" {
  description = "List of CIDRs allowed to reach AKS API server"
  type        = list(string)
  default     = []
}

#variable "address_space" {
# description = "VNet CIDR address space"
# type        = list(string)
#}

#variable "subnets" {
# description = "Subnet configuration map: aks, db, ingress"
# type = map(object({
#   address_prefixes = list(string)
# }))
#}

variable "mysql_admin_username" {
  description = "MySQL flexible server admin username"
  type        = string
}

variable "mysql_sku_name" {
  description = "MySQL flexible server SKU"
  type        = string
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
}

variable "mysql_storage_mb" {
  description = "MySQL storage (MB)"
  type        = number
  default     = 32768
}

variable "tags" {
  description = "Base tags to apply to all resources"
  type        = map(string)
  default     = {}
}
