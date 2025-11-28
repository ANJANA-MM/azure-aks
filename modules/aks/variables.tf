variable "prefix" {
  description = "Prefix for AKS resources (env included)"
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

variable "subnet_id" {
  description = "Subnet ID for AKS node pool"
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
}

variable "aad_admin_group_object_ids" {
  description = "AAD group IDs for AKS admin"
  type        = list(string)
}

variable "allowed_ip_ranges" {
  description = "Authorized IP ranges for AKS API server"
  type        = list(string)
}

variable "acr_id" {
  description = "ACR resource ID for AcrPull"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}
