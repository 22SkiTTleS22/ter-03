resource "yandex_compute_disk" "disks" {
    count = 3
    name  = "disk-${count.index + 1}"
    size  = 1
    zone  = var.default_zone
    type  = "network-hdd"
  }

  resource "yandex_compute_instance" "storage" {
    name        = "storage"
    platform_id = "standard-v3"
    zone        = var.default_zone

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

    dynamic "secondary_disk" {
      for_each = yandex_compute_disk.disks[*].id
      content {
        disk_id = secondary_disk.value
      }
    }

    network_interface {
      subnet_id          = yandex_vpc_subnet.develop.id
      nat                = false
      security_group_ids = [yandex_vpc_security_group.example.id]
    }

    scheduling_policy {
      preemptible = var.vm_preemptible
    }

    metadata = {
      ssh-keys = "ubuntu:${local.ssh_key}"
    }
  }

