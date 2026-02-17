
# Terraform RDS Module

Este módulo Terraform é responsável pelo provisionamento de instâncias **AWS RDS**, permitindo configuração flexível e reutilizável para diferentes ambientes.

## 📌 Versão v1.0.4

A versão **v1.0.4** é uma nova feature na qual agora também podemos trabalhar com **Deployment blue green** na qual conseguimos realizar upgrade, alteração de storage e outras alterações com downtime minimo, detalhe negativo é que para adicionamos esta feature precisamos remover o option group customizado e a integração com o Secrets Manager na qual tinha adicionando na versão anterios **v1.0.3**, pois essas features são incompatíveis com o Blue/Green.

- Parâmetros customizados
- Parâmetros com `apply_method` (`immediate` ou `pending-reboot`)
- Total flexibilidade para diferentes engines e versões
- Deployment Blue/Green



---

## 🚀 Principais Recursos

- Deploy de RDS PostgreSQL, MySQL e MariaDB
- Suporte a múltiplos parâmetros via lista
- Compatível com diferentes ambientes (`dev`, `qa`, `prod`)
- Deployment Blue/Green

Nesta versão é importante passar os seguintes campos para que seja realizado a criação com sucesso. 

```hcl 
blue_green_update           = true
```


---

## 🧩 Ponto de Atenção.
Lembrando caso você faço o git clone do repositório é necessário apenas que você altere o arquivo terraform.tfvars para que o seu deploy seja realizado. Segue link do repositório que faz a chamado para uso do modulo:
https://github.com/Matheusvavilla/rds-module-remote/tree/master

## 🧩 Exemplo de Uso
### terraform.tfvars

```hcl
environment                 = "dev"
identifier                  = "labmva"
db_name                     = "teste123"
engine                      = "postgres"
engine_version              = "17.5"
allow_major_version_upgrade = true
blue_green_update           = true
instance_class              = "db.t4g.micro"
storage_type                = "gp2"
allocated_storage           = "10"
username                    = "mvadba"
password                    = "Welcome#1234"

#manage_master_user_password = true
backup_retention_period = 1
backup_window           = "21:00-22:00"
skip_final_snapshot     = true

##parameter_group
parameter_group        = aws_db_parameter_group.parameter_group.name
parameter_group_family = "postgres17" #Exemplo mysql8.4 ou postgresql16

db_parameters = [
  {
    name         = "rds.logical_replication"
    value        = "1"
  }
]
```
