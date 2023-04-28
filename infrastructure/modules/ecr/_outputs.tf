output "ecr_repository_name" {
  value = aws_ecr_repository.ecr_repository.name
}

output "ecr_repository_token" {
  value = data.aws_ecr_authorization_token.ecr_repository_token.authorization_token
}

# output "aws_ecr_image" {
#     value = aws_ecr_image.ecr_image.
# }
