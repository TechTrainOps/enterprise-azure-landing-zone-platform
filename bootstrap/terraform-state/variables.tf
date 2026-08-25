variable "project_name" {
  description = "Short name of the project."
  type        = string
}

variable "location" {
  description = "Azure region for the Terraform state backend."
  type        = string
}

variable "environment" {
  description = "Environment name for the Terraform state backend."
  type        = string
}

variable "tags" {
  description = "Common tags applied to the Terraform state backend resources."
  type        = map(string)
}