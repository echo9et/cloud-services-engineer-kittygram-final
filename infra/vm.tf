resource "yandex_compute_image" "ubuntu_image" {
  source_family = var.image_family
}

resource "yandex_compute_instance" "vm_1" {
  name        = var.vm_1_name
  hostname    = var.vm_1_name
  zone        = var.zone
  platform_id = var.platform_id

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      type     = var.disk_type
      image_id = yandex_compute_image.ubuntu_image.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.infra_subnet.id
    nat                = var.nat
    security_group_ids = [yandex_vpc_security_group.infra_sg.id]
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys = "${var.vm_1_user}:${var.ssh_key}"
    "user-data" = file("${path.module}/cloud-init.yaml")
  }
}