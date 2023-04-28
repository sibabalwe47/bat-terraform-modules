#Generate a random admin password for the db

resource "random_password" "password" {
  length           = 16
  special          = false
  #override_special = "_%@"
}

#Creating Master DB secret
resource "aws_secretsmanager_secret" "secretmasterDB" {
   name = "VayaWallet_DB_Credentials"
}

#Creating a secret version for VayaWallet DB
resource "aws_secretsmanager_secret_version" "adminsecrets" {
  secret_id     = aws_secretsmanager_secret.secretmasterDB.id
  secret_string =  <<EOF
   {
    "username": "VayaWallet_Admin",
    "password": "${random_password.password.result}"
   }
EOF
}

# Importing the AWS secrets created previously using arn.
 
data "aws_secretsmanager_secret" "secretmasterDB" {
  arn = aws_secretsmanager_secret.secretmasterDB.arn
}
 
# Importing the AWS secret version created previously using arn.
 
data "aws_secretsmanager_secret_version" "admincreds" {
  secret_id = data.aws_secretsmanager_secret.secretmasterDB.arn
}

# After importing the secrets store them into Locals
 
locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.admincreds.secret_string)
}