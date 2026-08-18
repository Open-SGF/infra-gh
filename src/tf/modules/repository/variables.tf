variable "name" {
  description = "Repository name"
  type        = string
}

variable "description" {
  description = "Repository description"
  type        = string
  default     = null
}

variable "homepage_url" {
  description = "Repository homepage URL"
  type        = string
  default     = null
}

variable "visibility" {
  description = "Repository visibility"
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private", "internal"], var.visibility)
    error_message = "Visibility must be public, private, or internal."
  }
}

variable "topics" {
  description = "Repository topics"
  type        = set(string)
  default     = []
}

variable "required_checks" {
  description = "Status checks required before merging"
  type = set(object({
    context        = string
    integration_id = optional(number)
  }))
  default = []
}

variable "required_approving_review_count" {
  description = "Number of approving reviews required before merging"
  type        = number
  default     = 1

  validation {
    condition     = var.required_approving_review_count >= 0 && var.required_approving_review_count <= 6
    error_message = "Required approving review count must be between 0 and 6."
  }
}

variable "ruleset_enforcement" {
  description = "Main branch ruleset enforcement level"
  type        = string
  default     = "active"

  validation {
    condition     = contains(["active", "disabled", "evaluate"], var.ruleset_enforcement)
    error_message = "Ruleset enforcement must be active, disabled, or evaluate."
  }
}

variable "teams" {
  description = "Teams with access to the repository"
  type = list(object({
    id         = number
    permission = string
    bypass     = optional(bool, false)
  }))
  default = []

  validation {
    condition = alltrue([
      for team in var.teams :
      contains(["pull", "triage", "push", "maintain", "admin"], team.permission)
    ])
    error_message = "Team permissions must be pull, triage, push, maintain, or admin."
  }
}
