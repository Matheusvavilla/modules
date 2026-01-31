resource "aws_db_option_group" "options_group" {
  name                     = "${var.identifier}${var.engine}${replace(var.engine_version, ".", "")}"
  option_group_description = "Terraform Option Group"
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version
/*
  dynamic "optionsgroup" {
    for_each = var.db_optionsgroup
    content {
      name         = optionsgroup.value.name
      value        = optionsgroup.value.value
    }
  }
  */
}