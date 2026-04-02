locals {
  common_tags = merge(var.tags, {
    Module = "dynamodb_table"
  })
  # Function to extract all attributes for a single table
  key_attributes = [
    {
      name = "${var.hash_key}"
      type = "S"
    }
  ]
  range_key_attribute = var.range_key != null ? [{
    name = "${var.range_key}"
    type = "S"
  }] : []
  additional_attributes = flatten([for gsi in var.global_secondary_indexes : [
    for key in gsi.key_schema : {
      name = key.attribute_name
      type = lookup(key, "attribute_type", "S")
    }
  ]])
  table_attributes = concat(local.key_attributes, local.range_key_attribute, local.additional_attributes)
}

resource "aws_dynamodb_table" "this" {
  name                        = var.table_name
  billing_mode                = var.billing_mode
  read_capacity               = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity              = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  deletion_protection_enabled = var.deletion_protection_enabled

  dynamic "attribute" {
    for_each = local.table_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes

    content {
      name = global_secondary_index.value.name

      dynamic "key_schema" {
        for_each = global_secondary_index.value.key_schema
        content {
          attribute_name = key_schema.value.attribute_name
          key_type       = key_schema.value.key_type
        }
      }
      read_capacity      = var.billing_mode == "PROVISIONED" ? global_secondary_index.value.read_capacity : null
      write_capacity     = var.billing_mode == "PROVISIONED" ? global_secondary_index.value.write_capacity : null
      non_key_attributes = global_secondary_index.value.non_key_attributes
      projection_type    = global_secondary_index.value.projection_type
    }
  }

  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name
  }

  point_in_time_recovery {
    enabled                 = var.point_in_time_recovery
    recovery_period_in_days = var.recovery_period_in_days
  }
  # Optional: Enable DynamoDB Streams for change data capture
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null # Only if streams are enabled

  tags = local.common_tags
}
