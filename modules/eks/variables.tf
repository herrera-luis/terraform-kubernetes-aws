variable "vpc_id" {
  description = "the vpc id"
  type        = string
}

variable "cluster_name" {
  description = "the cluster name"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet ids"
  type        = list(string)
  default     = []
}
