###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}
<<<<<<< HEAD
=======

  ###vm vars
  variable "vm_image_family" {
    type        = string
    default     = "ubuntu-2004-lts"
    description = "Yandex Cloud image family for VMs"
  }

  variable "vm_resources" {
    type = object({
      cores         = number
      memory        = number
      core_fraction = number
    })
    default = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
    description = "Minimal cheap VM resources: 2 cores at 20% fraction, 1GB RAM"
  }

  variable "vm_preemptible" {
    type        = bool
    default     = true
    description = "Use preemptible (spot) VM to minimize cost"
  }

>>>>>>> c5956d5 (Task 2.1)
