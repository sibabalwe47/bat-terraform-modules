resource "aws_ecs_task_definition" "cluster_task_definition" {
  family = var.ecs_cluster_task_definition_name
  container_definitions = jsonencode([
    {
      name      = "${var.ecs_cluster_task_definition_container_name}"
      image     = "${var.ecs_cluster_task_definition_container_image}"
      cpu       = "${var.ecs_cluster_task_definition_container_cpu}"
      memory    = "${var.ecs_cluster_task_definition_container_memory}"
      essential = true
      readonly = true
      portMappings = [
        {
          containerPort = "${var.ecs_cluster_task_definition_container_port}"
          hostPort      = "${var.ecs_cluster_task_definition_container_host_port}"
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  ephemeral_storage {
    size_in_gib = 21
  }

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}
