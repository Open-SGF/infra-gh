variable "name" {
  description = "Team name"
  type        = string
}

variable "description" {
  description = "Team description"
  type        = string
  default     = ""
}

variable "members" {
  description = "Team members and their roles"
  type = list(object({
    username = string
    role     = optional(string, "member")
  }))
  default = []

  validation {
    condition     = alltrue([for member in var.members : contains(["member", "maintainer"], member.role)])
    error_message = "Member roles must be member or maintainer."
  }
}
