
# Terraform RDS Module

Este módulo Terraform é responsável pelo provisionamento de instâncias **AWS RDS**, permitindo configuração flexível e reutilizável para diferentes ambientes.

## 📌 Versão v1.0.2

A versão **v1.0.2** foi criada com foco na implementação de **Parameter Groups dinâmicos**, permitindo que o usuário informe **quaisquer parâmetros do banco de dados sem restrições**, incluindo:

- Parâmetros customizados
- Parâmetros com `apply_method` (`immediate` ou `pending-reboot`)
- Total flexibilidade para diferentes engines e versões

Essa abordagem elimina a necessidade de alterar o módulo sempre que um novo parâmetro precisar ser adicionado.

---

## 🚀 Principais Recursos

- Deploy de RDS PostgreSQL e MySQL
- Criação e associação de **DB Parameter Group dinâmico**
- Suporte a múltiplos parâmetros via lista
- Compatível com diferentes ambientes (`dev`, `qa`, `prod`)
- Integração com Secrets Manager para senha do master user

Nesta versão é importante passar os seguintes campos para que seja realizado a criação com sucesso. 

```hcl 
parameter_group_family = "postgres15"

db_parameters = [
  {
    name  = "enable_partition_pruning"
    value = "1"
    apply_method = "immediate"
  },
  {
    name  = "shared_preload_libraries"
    value = "pg_cron, auto_explain"
    apply_method = "immediate"
  }
]
```


---

## 🧩 Ponto de Atenção.
Lembrando caso você faço o git clone do repositório é necessário apenas que você altere o arquivo terraform.tfvars para que o seu deploy seja realizado. 

## 🧩 Exemplo de Uso
### terraform.tfvars

```hcl
environment                 = "dev"
identifier                  = "labmva"
db_name                     = "db_terraform"
engine                      = "postgres"
engine_version              = "15.7"
instance_class              = "db.t4g.micro"
storage_type                = "gp2"
allocated_storage           = "10"
username                    = "mvadba"
manage_master_user_password = true
backup_retention_period     = 1
backup_window               = "21:00-22:00"
skip_final_snapshot         = true

parameter_group = aws_db_parameter_group.parameter_group.name

##parameter_group
parameter_group_family = "postgres15"
db_parameters = [
  {
    name  = "enable_partition_pruning"
    value = "1"
    apply_method = "immediate"
  },
  {
    name  = "shared_preload_libraries"
    value = "pg_cron, auto_explain"
    apply_method = "immediate"
  }
]

