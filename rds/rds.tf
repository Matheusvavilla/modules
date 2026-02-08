resource "aws_db_instance" "mydbterraform" {
  identifier                  = "${var.identifier}-${var.engine}-${var.environment}"
  db_name                     = var.db_name
  engine                      = var.engine
  engine_version              = var.engine_version
  allow_major_version_upgrade = var.allow_major_version_upgrade

  instance_class = var.instance_class

  parameter_group_name = aws_db_parameter_group.parameter_group.name #Onde realizamos associação do parameter group com o RDS.

  option_group_name = aws_db_option_group.options_group.name # Associando o Options Group.

  storage_type      = var.storage_type
  allocated_storage = var.allocated_storage

  username                    = var.username
  password = var.password
  #manage_master_user_password = true



  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  apply_immediately       = var.apply_immediately

  tags = {
    managed          = "Managed by terraform"
    terraform-module = "yes"
  }

}