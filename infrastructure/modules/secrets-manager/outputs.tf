output "username" {
    value = jsondecode(data.aws_secretsmanager_secret_version.admincreds.secret_string)["username"]
    sensitive = true
}

output "password" {
    value = jsondecode(data.aws_secretsmanager_secret_version.admincreds.secret_string)["password"]
  sensitive = true
}