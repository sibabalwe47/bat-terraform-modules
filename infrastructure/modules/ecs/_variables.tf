variable "ecs_cluster_name" {
  type = string
}

variable "ecs_cluster_task_definition_name" {
  type = string
}


variable "ecs_cluster_task_definition_container_name" {
  type = string
}

variable "ecs_cluster_task_definition_container_image" {
  type = string
}

variable "ecs_cluster_task_definition_container_cpu" {
  type = number
}

variable "ecs_cluster_task_definition_container_memory" {
  type = number
}

variable "ecs_cluster_task_definition_container_port" {
  type = number
}

variable "ecs_cluster_task_definition_container_host_port" {
  type = number
}

variable "ecs_cluster_service_name" {
  type = string
}

variable "ecs_cluster_service_subnet_ids" {
  type = list(string)
}

variable "ecs_cluster_service_security_groups" {
  type = list(string)
}


variable "ecs_cluster_service_alb_target_group_arn" {
  type = string
}
