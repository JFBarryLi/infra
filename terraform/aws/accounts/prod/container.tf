module "fea_container" {
  source = "../../../modules/container"

  repo_name        = "fea"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_public_ids
  ecs_cluster_name = "fea-cluster"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]
}
