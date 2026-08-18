resource "github_repository" "this" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url
  visibility   = var.visibility
  topics       = var.topics

  has_issues      = true
  has_projects    = true
  has_wiki        = false
  has_discussions = false

  allow_merge_commit  = false
  allow_squash_merge  = true
  allow_rebase_merge  = true
  allow_auto_merge    = true
  allow_update_branch = true

  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  delete_branch_on_merge = true
}

resource "github_team_repository" "this" {
  count = length(var.teams)

  team_id    = var.teams[count.index].id
  repository = github_repository.this.name
  permission = var.teams[count.index].permission
}

resource "github_repository_ruleset" "main" {
  name        = "Protect main"
  repository  = github_repository.this.name
  target      = "branch"
  enforcement = var.ruleset_enforcement

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  dynamic "bypass_actors" {
    for_each = [for team in var.teams : team if team.bypass]

    content {
      actor_id    = bypass_actors.value.id
      actor_type  = "Team"
      bypass_mode = "always"
    }
  }

  rules {
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true

    pull_request {
      allowed_merge_methods             = ["rebase", "squash"]
      dismiss_stale_reviews_on_push     = true
      required_approving_review_count   = var.required_approving_review_count
      required_review_thread_resolution = true
    }

    dynamic "required_status_checks" {
      for_each = length(var.required_checks) == 0 ? [] : [var.required_checks]

      content {
        strict_required_status_checks_policy = true

        dynamic "required_check" {
          for_each = required_status_checks.value

          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
      }
    }
  }
}
