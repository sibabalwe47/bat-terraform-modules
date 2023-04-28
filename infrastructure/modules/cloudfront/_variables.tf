variable "acm_certification_arn" {
  type = string
}

variable "project_name" {
  type = string
}

variable "alb_origin_id" {
  type = string
}

variable "domain_aliases" {
  type = list(string)
}

variable "domain_name" {
  type = string
}
