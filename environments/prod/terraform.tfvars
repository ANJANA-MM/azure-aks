environment  = "prod"
# location     = "southeastasia"
prefix       = "platform"

kubernetes_version = "1.29.0"

aad_admin_group_object_ids = [
  "00000000-0000-0000-0000-000000000000"
]

api_server_authorized_ip_ranges = [
  "0.0.0.0/0"
]

# address_space = ["10.30.0.0/16"]

# subnets = {
#   aks = {
#     address_prefixes = ["10.30.10.0/24"]
#   }
#   db = {
#     address_prefixes = ["10.30.20.0/24"]
#   }
#   ingress = {
#     address_prefixes = ["10.30.30.0/24"]
#   }
# }

mysql_admin_username = "mysqladmin"
mysql_sku_name       = "GP_Standard_D2ds_v4"
mysql_version        = "8.0.21"
mysql_storage_mb     = 32768

database_name        = "appdb"
server_name          = "mysql"


tags = {
  Environment = "prod"
  Application = "platform"
  Owner       = "team-devops"
  CostCenter  = "CC-PROD"
}
