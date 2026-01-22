resource "aws_db_instance" "mydbterraform" {
  identifier     = "${var.identifier}-${var.engine}-${var.environment}"
  db_name        = var.db_name
  engine         = var.engine
  engine_version = var.engine_version


  instance_class = var.instance_class

  storage_type      = var.storage_type
  allocated_storage = var.allocated_storage

  username                    = var.username
  manage_master_user_password = true

  skip_final_snapshot = var.skip_final_snapshot
  apply_immediately   = var.apply_immediately

}