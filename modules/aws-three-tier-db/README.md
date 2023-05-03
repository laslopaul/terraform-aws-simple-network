# aws-three-tier-db

This Terraform module creates two AWS RDS instances (main and replica) in two different availability zones. The RDS instances use MySQL 8.0 engine. This parameter can be adjusted by editing `local.db_engine` and `local.db_engine_version` variables.

## Module inputs

- `db_name` (string) - name of the database that will be created in the instance
- `db_instance_class` (string) - the instance type of the RDS instance (e.g. `db.t3.micro`)
- `db_storage_size` (number) - the allocated RDS instance storage in gibibytes
- `db_subnets` (list(string)) - list of VPC subnets to associate with the RDS instance
- `db_security_group` (string) - VPC security group to associate with the RDS instance
- `db_username` (string) - RDS instance root username
- `db_password` (string) - RDS instance root password
- `backup_retention_period` (number) - the number of days to retain database backups for
- `azs` (list(string)) - list of availability zones (primary for the main DB and secondary for the replica)

## Module outputs

- `db_hostname` (string) - RDS instance hostname
- `db_port` (number) - RDS instance port
- `db_username` (string) - RDS instance root username
- `db_password` (string) - RDS instance root password
