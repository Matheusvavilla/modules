
# Terraform RDS Module

Este módulo Terraform é responsável pelo provisionamento de instâncias **AWS RDS**, permitindo configuração flexível e reutilizável para diferentes ambientes.

## 📌 Versão v1.0.3

A versão **v1.0.3** é uma nova feature na qual agora também podemos trabalhar com **Option Group com parametros dinamicos** e não apenas com parameter group, permitindo que o usuário informe **quaisquer parâmetros do banco de dados sem restrições**, incluindo:

- Parâmetros customizados
- Parâmetros com `apply_method` (`immediate` ou `pending-reboot`)
- Total flexibilidade para diferentes engines e versões

Essa abordagem elimina a necessidade de alterar o módulo sempre que um novo parâmetro precisar ser adicionado.

---

## 🚀 Principais Recursos

- Deploy de RDS PostgreSQL, MySQL e MariaDB
- Criação e associação de **Option Group**
- Suporte a múltiplos parâmetros via lista
- Compatível com diferentes ambientes (`dev`, `qa`, `prod`)
- Integração com Secrets Manager para senha do master user

Nesta versão é importante passar os seguintes campos para que seja realizado a criação com sucesso. 

```hcl 
options_group        = aws_db_option_group.options_group.name
major_engine_version = "8.4" #De acordo com a major version da engine que você está usando
option_name          = "MARIADB_AUDIT_PLUGIN"

db_options = [
  {
    name  = "SERVER_AUDIT_FILE_ROTATIONS"
    value = "51"
  },
  {
    name  = "SERVER_AUDIT_FILE_ROTATE_SIZE"
    value = "100000"
  }
]
```


---

## 🧩 Ponto de Atenção.
Lembrando caso você faço o git clone do repositório é necessário apenas que você altere o arquivo terraform.tfvars para que o seu deploy seja realizado. Segue link do repositório que faz a chamado para uso do modulo:
https://github.com/Matheusvavilla/rds-module-remote/tree/master

## 🧩 Exemplo de Uso
### terraform.tfvars

```hcl
environment       = "dev"
identifier        = "labmva"
db_name           = "db_terraform"
engine            = "mysql"
engine_version    = "8.4.6"
instance_class    = "db.t4g.micro"
storage_type      = "gp2"
allocated_storage = "10"
username          = "mvadba"
password          = "Welcome#1234"

#manage_master_user_password = true
backup_retention_period = 0
backup_window           = "21:00-22:00"
skip_final_snapshot     = true

##parameter_group
parameter_group        = aws_db_parameter_group.parameter_group.name
parameter_group_family = "mysql8.4" #Exemplo mysql8.4 ou postgresql16
db_parameters = [
  {
    name  = "autocommit"
    value = "1"
  }
]
###Optins group link para apoio.
/*
MySQL: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.MySQL.Options.AuditPlugin.html
Oracle: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.Options.overview.html
SQL Server: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.SQLServer.Options.html
*/
options_group        = aws_db_option_group.options_group.name
major_engine_version = "8.4" #De acordo com a major version da engine que você está usando
option_name          = "MARIADB_AUDIT_PLUGIN"

db_options = [
  {
    name  = "SERVER_AUDIT_FILE_ROTATIONS"
    value = "51"
  },
  {
    name  = "SERVER_AUDIT_FILE_ROTATE_SIZE"
    value = "100000"
  }
]
