variable "backend" {
  description = "A map of backend configuration date for authenticating with SP."
  type        = map(string)
}

variable "tags" {
  description = "Map of tags to attach to resources."
  type        = map(string)
}

variable "resource_group_name" {
  description = "Name of resource group to hold app resources."
  type        = string
}

variable "location" {
  description = "The location to launch Azure resources."
  type        = string
}
