variable "environment" {
  description = "Ambiente para descrever se estamos usando DEV, QA ou PROD."
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "O valor environment é obrigatório"
  }
}

variable "identifier" {
  description = "Nome do RDS/Aurora"
  type        = string
}
variable "db_name" {
  description = "Nome da database"
  type        = string
}
variable "engine" {
  description = "Engine do banco de dados MySQL, PostgreSQL, Oracle, SQLServer..."
  type        = string
  validation {
    condition     = contains(["mysql", "postgresql"], var.engine)
    error_message = "O valor da variável engine deve ser 'mysql' ou 'postgresql'."
  }
}
variable "engine_version" {
  description = "Versão da engine do banco de dados, exemplo PostgreSQL 16.9"
  type        = string
}

variable "instance_class" {
  description = "Instance class do banco de dados, exemplo db.m6g.large"
  type        = string
}

variable "storage_type" {
  description = "Tipo do storage podendo ser GP2, GP3, IO1, IO2"
  type        = string
}
variable "allocated_storage" {
  description = "Capacidade de armazenamento do storage"
  type        = string
  default     = "10"
}

variable "username" {
  description = "Nome do usuário master"
  type        = string
  default     = "dba"
}

variable "skip_final_snapshot" {
  description = "Escolher de havera um snapshot final de backup ou destruiremos todo o recurso e snapshot"
  type        = bool
  default     = true
}
variable "apply_immediately" {
  description = "Aqui setamos true caso deseje realização ação imediatamente"
  type        = bool
  default     = true
}