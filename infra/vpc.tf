resource "yandex_vpc_network" "infra_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "infra_subnet" {
  name           = var.net_cidr[0].name
  zone           = var.net_cidr[0].zone    
  v4_cidr_blocks = [var.net_cidr[0].prefix]
  network_id     = yandex_vpc_network.infra_network.id
}

resource "yandex_vpc_security_group" "infra_sg" {
  name       = "${var.vpc_name}-sg"
  network_id = yandex_vpc_network.infra_network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}