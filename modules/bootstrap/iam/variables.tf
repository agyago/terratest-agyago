variable  "local_group_policy" {
    type = map(string)
    default = {
        "admin-group" = "arn:aws:iam::aws:policy/AdministratorAccess"
        "readonly-group" = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    }
}

variable "admin_names" {
  type    = list(string)
  default = []
}

variable "read_names" {
  type    = list(string)
  default = []
}