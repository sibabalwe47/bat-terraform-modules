# RANDOM NUMBER GENERATOR
resource "random_id" "backend_id" {
  keepers = {
    backend_state_bucket_name   = var.backend_state_bucket_name
    backend_state_dynamodb_name = var.backend_state_dynamodb_name
  }

  byte_length = 5
}

# BACKEND STATE MODULE
module "aws_backend_state" {
  source               = "../modules/backend"
  s3_state_bucket      = "${var.backend_state_bucket_name}-${random_id.backend_id.hex}"
  dynamodb_state_table = "${var.backend_state_dynamodb_name}-${random_id.backend_id.id}"
}

module "network_module" {
  source   = "../modules/network"
  vpc_name = "vayawallet-${var.environment}"
}

module "ecr_module" {
  source              = "../modules/ecr"
  ecr_repository_name = "vayawallet"
}


module "ecs_module" {
  source           = "../modules/ecs"
  ecs_cluster_name = "vayawallet-cluster-${var.environment}"

  # Task definition configuration
  ecs_cluster_task_definition_name                = "vayawallet-task-def-${var.environment}"
  ecs_cluster_task_definition_container_name      = "vayawallet-container-${var.environment}"
  ecs_cluster_task_definition_container_image     = "siba920429/vayawallet-img"
  ecs_cluster_task_definition_container_cpu       = 256
  ecs_cluster_task_definition_container_memory    = 512
  ecs_cluster_task_definition_container_port      = 80
  ecs_cluster_task_definition_container_host_port = 80

  # Service configuration
  ecs_cluster_service_name                 = "vayawallet-service-${var.environment}"
  ecs_cluster_service_subnet_ids           = [module.network_module.public_subnet_ids[0], module.network_module.public_subnet_ids[1]]
  ecs_cluster_service_security_groups      = [module.network_module.security_group]
  ecs_cluster_service_alb_target_group_arn = module.network_module.load_balancer_target_group_arn
}

module "database_module" {
  source                     = "../modules/database"
  database_security_group_id = [module.network_module.db_security_group_id]
  database_subnet_group_name = module.network_module.db_subnet_group.name
  availability_zone          = module.network_module.local_azs[0]
  database_name              = "vayawallet-db-${var.environment}"
  db_engine                  = "sqlserver-ex"
  db_engine_version          = "15.00.4236.7.v1"
  db_username                = module.secrets-manager_module.username
  db_password                = module.secrets-manager_module.password
  rds_multi_az               = true
  db_instance_type           = "db.t3.small"
  parameter_group_name       = "sqlserver-ex-15.0"
  
}

module "secrets-manager_module" {
  source = "../modules/secrets-manager"
 
}


module "roles_module" {
  source = "../modules/roles"
}

module "acm" {
  source = "../modules/acm"
  domain_name = "vayawallet.com"
  
}