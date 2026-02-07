resource "aws_db_option_group" "options_group" {
  name                     = "${var.identifier}${var.engine}${replace(var.engine_version, ".", "")}"
  option_group_description = "Terraform Option Group"
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"

    option_settings {
      name = "SERVER_AUDIT_EVENTS*"
      value = "CONNECT, QUERY, QUERY_DDL, QUERY_DML, QUERY_DCL, QUERY_DML_NO_SELECT"
    }
    option_settings {
      name = "SERVER_AUDIT_FILE_ROTATIONS"
      value = "50"
    }
  }
} 