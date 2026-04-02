module "users_table" {
  source = "../../shared-modules/dynamodb_table"
  # An example for users table
  table_name        = "users-table"
  hash_key          = "id"
  range_key         = "name"
  table_description = "Users Table"

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  global_secondary_indexes = [
    {
      name = "name-index"
      key_schema = [
        {
          attribute_name = "name"
          key_type       = "HASH"
        },
        {
          attribute_name = "age"
          key_type       = "RANGE"
        }
      ]
      non_key_attributes = ["age"]
      projection_type    = "INCLUDE"
      read_capacity      = 1
      write_capacity     = 1
    }
  ]
}

output "users_table_arn" {
  value = module.users_table.table_arn
}
