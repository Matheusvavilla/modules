resource "aws_db_parameter_group" "parameter_group" {
  name        = "${var.identifier}-${var.engine}${replace(var.engine_version, ".", "")}-parameter-group"
  family      = var.parameter_group_family
  description = "Parameter group criado via terraform"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}