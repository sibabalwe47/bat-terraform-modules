resource "aws_ecs_service" "cluster_service" {
  name            = var.ecs_cluster_service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.cluster_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 2
  depends_on = [
    aws_iam_role.ecs_task_execution_role
  ]

  load_balancer {
    target_group_arn = var.ecs_cluster_service_alb_target_group_arn
    container_name   = var.ecs_cluster_task_definition_container_name
    container_port   = var.ecs_cluster_task_definition_container_port
  }

  network_configuration {
    subnets          = ["${var.ecs_cluster_service_subnet_ids[0]}", "${var.ecs_cluster_service_subnet_ids[1]}"]
    assign_public_ip = true
    security_groups  = var.ecs_cluster_service_security_groups
  }
}
