data "yandex_compute_image" "ubuntu" {
    family = var.vm_image_family
  }

  locals {
    ssh_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  }

  resource "yandex_compute_instance" "web" {
    count       = 2
    name        = "web-${count.index + 1}"
    platform_id = "standard-v3"
    zone        = var.default_zone

    depends_on = [yandex_compute_instance.db]

    resources {
      cores         = var.vm_resources.cores
      memory        = var.vm_resources.memory
      core_fraction = var.vm_resources.core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu.image_id
      }
    }

    network_interface {
      subnet_id          = yandex_vpc_subnet.develop.id
      nat                = true
      security_group_ids = [yandex_vpc_security_group.example.id]
    }

    scheduling_policy {
      preemptible = var.vm_preemptible
    }

    metadata = {
      ssh-keys = "ubuntu:${local.ssh_key}"
    }
  }

