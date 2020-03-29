module "variables" {
  source      = "../modules/variables"
  environment = "staging"
}

module "main" {
  source = "../modules/main"

  project_name          = module.variables.project_name
  project_name_env      = module.variables.project_name_env
  environment           = module.variables.environment
  region                = module.variables.region
  log_retention_in_days = module.variables.log_retention_in_days
}

module "global" {
  source           = "../modules/global"

  project_name_env = module.variables.project_name_env
}

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  name = module.variables.project_name_env

  instance_type = module.variables.instance_type
  swap_size     = module.variables.swap_size

  number_of_instances     = module.variables.min_task_count
  min_number_of_instances = module.variables.min_task_count
  max_number_of_instances = module.variables.max_task_count

  key_pair                          = module.main.aws_key_pair
  subnet_ids                        = module.global.default_subnet_ids
  cluster_instance_sg               = aws_security_group.cluster_instance
  ecs_instance_iam_instance_profile = module.global.ecs_instance_iam_instance_profile
}
