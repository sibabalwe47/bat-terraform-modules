resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


data "aws_ecr_repository" "ecr_repository_name" {
  name = var.ecr_repository_name

  depends_on = [
    aws_ecr_repository.ecr_repository
  ]
}
