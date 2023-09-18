variable "env" {
  description = "Environment"
  type        = string
  default = "dev"
}

variable "owner" {
  description = "Project Owner"
  type        = string
  default = "example"
}

variable "service" {
  description = "Service project"
  type        = string
  default = "app"
}

variable "bucket_name" {
  description = "Name of the bucket s3"
  type        = string
}
