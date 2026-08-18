provider "github" {
  owner = local.github_organization

  app_auth {
    id              = "4642059"
    installation_id = "154790900"
    pem_file        = var.github_app_pem
  }
}
