source "virtualbox-iso" "almalinux-8" {
    guest_os_type = "Redhat_64"
    iso_url = "http://mirrors.pt/almalinux/8.7/isos/x86_64/AlmaLinux-8.7-update-1-x86_64-minimal.iso"
    iso_checksum = "sha256:abab7abbc08b80f045293e4f6a41cc7376a6ed827423374c12e1db4537cc86ff"

    cpus = 2
    memory = 1024

    cd_content = {
        "almalinux-8.ks" = templatefile("./almalinux-8-ks.tpl", {
            username = "packer"
        })
    }

    boot_wait = "15s"
    boot_command = [
        "<tab> inst.text inst.ks=cdrom:/dev/sr1:/almalinux-8.ks<enter><wait>"
    ]


    shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

    communicator = "ssh"
    ssh_username = "packer"
    ssh_password = "packer"

    ssh_timeout = "15m"
}

build {
    sources = ["sources.virtualbox-iso.almalinux-8"]
}