resource "aws_db_option_group" "options_group" {
  name                     = "${var.identifier}${var.engine}${replace(var.engine_version, ".", "")}"
  option_group_description = "Terraform Option Group"
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version
  option {
    option_name = var.option_name

    dynamic "option_settings" {
      for_each = var.db_options
      content {
        name  = option_settings.value.name
        value = option_settings.value.value
      }
    }
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}
