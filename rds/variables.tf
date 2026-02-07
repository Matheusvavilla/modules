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
  description = "Engine do banco de dados MySQL, PostgreSQL, MariaDB"
  type        = string
  validation {
    condition     = contains(["mariadb", "mysql", "postgres"], var.engine)
    error_message = "O valor da variável engine deve ser 'mysql', 'mariadb' ou 'postgres'."
  }
}

variable "engine_version" {
  description = "Versão da engine do banco de dados, exemplo PostgreSQL 16.9"
  type        = string
}
variable "allow_major_version_upgrade" {
  description = "Upgrade major version"
  type        = bool
  default     = true
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

variable "backup_retention_period" {
  description = "Periodo de retenção do backup"
  type        = number
  default     = 0
}
variable "backup_window" {
  description = "Janela de execução do backup"
  type        = string
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


###### Variables Parameter Group.

variable "parameter_group_family" {
  description = "Familia do parameter group MySQL(mysql8.4), PostgreSQL(postgres16) "
  type        = string
}

variable "db_parameters" {
  description = "Lista de parâmetros do DB Parameter Group"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "pending-reboot")
  }))

  default = []

  validation {
    condition = alltrue([
      for p in var.db_parameters :
      contains(["immediate", "pending-reboot"], p.apply_method)
    ])
    error_message = "apply_method deve ser 'immediate' ou 'pending-reboot'."
  }
}


###### Variables Options Group.

variable "major_engine_version" {
  description = "Versão major do seu database para criação do Options Group dinâmico"
  type        = string
}
variable "option_name" {
  description = "option name do option group, exemplos: MARIADB_AUDIT_PLUGIN"
  type        = string
  default     = ""
}
variable "db_options" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
