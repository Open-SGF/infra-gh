locals {
  github_actions_integration_id = 15368

  organizers_team = {
    id         = module.organizers_team.id
    permission = "admin"
    bypass     = true
  }
}

module "portal_to_work_app_old_repository" {
  source = "./modules/repository"

  name  = "Portal-To-Work-App-Old"
  teams = [local.organizers_team]
}

module "opensgf_org_repository" {
  source = "./modules/repository"

  name         = "opensgf.org"
  description  = "Organization website"
  homepage_url = "https://www.opensgf.com/"
  topics       = ["hacktoberfest"]
  teams        = [local.organizers_team]
}

module "brigade_information_repository" {
  source = "./modules/repository"

  name        = "brigade-information"
  description = "Data about Code for America brigades and other civic tech organizations for the CfA API"
  teams       = [local.organizers_team]
}

module "portal_to_work_api_old_repository" {
  source = "./modules/repository"

  name        = "portal-to-work-api-old"
  description = "API for portal to work https://github.com/Open-SGF/Portal-To-Work-App"
  teams       = [local.organizers_team]
}

module "motherhood_reclaimed_website_repository" {
  source = "./modules/repository"

  name   = "motherhood-reclaimed-website"
  topics = ["hacktoberfest"]
  teams  = [local.organizers_team]
}

module "portal_to_work_client_repository" {
  source = "./modules/repository"

  name   = "portal-to-work-client"
  topics = ["hacktoberfest"]
  teams  = [local.organizers_team]
}

module "portal_to_work_api_repository" {
  source = "./modules/repository"

  name  = "portal-to-work-api"
  teams = [local.organizers_team]
}

module "discord_bot_repository" {
  source = "./modules/repository"

  name        = "discord-bot"
  description = "Our little discord bot"
  topics      = ["hacktoberfest"]
  teams       = [local.organizers_team]
}

module "invisible_man_leadership_repository" {
  source = "./modules/repository"

  name  = "invisiblemanleadership.org"
  teams = [local.organizers_team]
}

module "sgf_meetup_api_repository" {
  source = "./modules/repository"

  name  = "sgf-meetup-api"
  teams = [local.organizers_team]
  required_checks = [
    {
      context        = "build"
      integration_id = local.github_actions_integration_id
    },
    {
      context        = "lint-test / lint-test"
      integration_id = local.github_actions_integration_id
    },
  ]
}

module "gooddads_repository" {
  source = "./modules/repository"

  name = "gooddads"
  teams = concat(
    [{
      id         = module.good_dads_volunteers_team.id
      permission = "triage"
    }],
    [local.organizers_team],
  )
}

module "good_dads_admin_app_repository" {
  source = "./modules/repository"

  name  = "good-dads-admin-app"
  teams = [local.organizers_team]
}

module "good_dads_companion_app_repository" {
  source = "./modules/repository"

  name  = "good-dads-companion-app"
  teams = [local.organizers_team]
}

module "healthiermo_repository" {
  source = "./modules/repository"

  name                = "healthiermo"
  ruleset_enforcement = "disabled"
  teams               = [local.organizers_team]
  required_checks = [
    {
      context        = "Test"
      integration_id = local.github_actions_integration_id
    },
    {
      context        = "Build"
      integration_id = local.github_actions_integration_id
    },
    {
      context        = "Validate PR title"
      integration_id = local.github_actions_integration_id
    },
  ]
}

module "take_shelter_now_repository" {
  source = "./modules/repository"

  name         = "take-shelter-now"
  homepage_url = "https://www.takeshelternow.org"
  teams = concat(
    [{
      id         = module.take_shelter_now_volunteers_team.id
      permission = "triage"
    }],
    [local.organizers_team],
  )
  required_checks = [
    {
      context        = "ci"
      integration_id = local.github_actions_integration_id
    },
    {
      context        = "ci-e2e"
      integration_id = local.github_actions_integration_id
    },
  ]
}

module "gooddads_enrollment_bot_repository" {
  source = "./modules/repository"

  name = "gooddads-enrollment-bot"
  teams = concat(
    [{
      id         = module.good_dads_volunteers_team.id
      permission = "pull"
    }],
    [local.organizers_team],
  )
}

module "infra_aws_core_repository" {
  source = "./modules/repository"

  name        = "infra-aws-core"
  description = "Open SGF shared AWS foundation infrastructure"
  teams       = [local.organizers_team]
}

module "infra_dns_repository" {
  source = "./modules/repository"

  name        = "infra-dns"
  description = "Open SGF DNS infrastructure as code"
  teams       = [local.organizers_team]
}

module "infra_gh_repository" {
  source = "./modules/repository"

  name        = "infra-gh"
  description = "Manages OpenSGF GitHub organization configuration with OpenTofu"
  teams       = [local.organizers_team]
}
