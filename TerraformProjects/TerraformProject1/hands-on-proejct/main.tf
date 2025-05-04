# here we will create actaul infra resource for the project
# this provider block allows terraform to interact with cloud provider , it acts like a API.

provider "google" {
    project = var.project_id
    region = var.region1
}

resource "google_compute_instance" "my_vm" {
    name = var.instance_name
    machine_type = var.machine_type
    zone = var.zone
    boot_disk {
        initialize_params {
            # OS name
            image = "debian-cloud/debian-11"

            # size of the boot disk
            size = 10
        }
    }

    network_interface {
        network = "default"
        access_config {

        }
    }

    # tages used for network firewals and other services to identification
    tags = ["webserver", "terraform-demo"]

    metadata = {
        block-proejct-ssh-keys = false
    }


    
}



