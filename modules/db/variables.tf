variable "prefix" {
  description = "Prefix for DB resources (env included)"
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

variable "vnet_id" {
  description = "VNet ID for private DNS link"
  type        = string
}

variable "delegated_subnet_id" {
  description = "Delegated subnet ID for MySQL Flexible Server"
  type        = string
}

variable "admin_username" {
  description = "MySQL admin username"
  type        = string
}

variable "sku_name" {
  description = "MySQL Flexible SKU name"
  type        = string
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
}


variable "storage_gb" {
  description = "Storage size in GB"
  type        = number
}

variable "database_name" {
  description = "Name of application database"
  type        = string
}

variable "server_name" {
  description = "MySQL server name without prefix"
  type        = string
  default     = "mysql"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}

