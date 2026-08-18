locals {
  members_by_username = {
    for username, memberships in {
      for member in var.members : member.username => member...
      } : username => {
      username = username
      role = contains(
        [for membership in memberships : membership.role],
        "maintainer",
      ) ? "maintainer" : "member"
    }
  }
}

resource "github_team" "this" {
  name                 = var.name
  description          = var.description
  privacy              = "closed"
  notification_setting = "notifications_enabled"
}

resource "github_team_membership" "this" {
  for_each = local.members_by_username

  team_id  = github_team.this.id
  username = each.value.username
  role     = each.value.role
}
