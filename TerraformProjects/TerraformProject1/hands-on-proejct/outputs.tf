# so this output file is usefull for the results of output
# if you wannaa see the results after apply done from the cli , insated of console you can see 
# if you wanna add the results of the resouce like instance ID , 
# - wanna add somewhere in the configuration you can simple give output of the vm id so it will read and make confguration done

output "instance_id" {
    description = "it will show instance ID after apply done"
    value = google_compute_instance.my_vm.id
}

output "instance_name" {
    description = "will give instance name"
    value = google_compute_instance.my_vm.name
}

output "External_IP" {
    description = " this is public IP which is used for internet"
    value = google_compute_instance.my_vm.network_interface[0].access_config[0].nat_ip
}

output "Internal_IP" {
    description = "private internal ip"
    value = google_compute_instance.my_vm.network_interface[0].network_ip
}