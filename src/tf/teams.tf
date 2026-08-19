module "good_dads_volunteers_team" {
  source = "./modules/team"

  name = "Good Dads Volunteers"
  members = [
    {
      username = github_membership.glitchedmob.username
      role     = "maintainer"
    },
    {
      username = github_membership.jugglingdev.username
      role     = "maintainer"
    },
    {
      username = github_membership.thing_engineer.username
    },
    {
      username = github_membership.ntoombs19.username
    },
    {
      username = github_membership.jason_klein.username
    },
    {
      username = github_membership.nomedis.username
    },
  ]
}

module "organizers_team" {
  source = "./modules/team"

  name = "Organizers"
  members = [
    {
      username = github_membership.glitchedmob.username
      role     = "maintainer"
    },
    {
      username = github_membership.jugglingdev.username
      role     = "maintainer"
    },
  ]
}

module "infra_maintainers_team" {
  source = "./modules/team"

  name = "Infra Maintainers"
  members = [
    {
      username = github_membership.glitchedmob.username
      role     = "maintainer"
    },
    {
      username = github_membership.sm0862512.username
    },
  ]
}

module "take_shelter_now_volunteers_team" {
  source = "./modules/team"

  name = "Take Shelter Now Volunteers"
  members = [
    {
      username = github_membership.glitchedmob.username
      role     = "maintainer"
    },
    {
      username = github_membership.sm0862512.username
    },
  ]
}
