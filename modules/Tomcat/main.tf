resource "null_resource" "provision_web" {

  connection {
    host     = var.vm_ipadress
    type     = "winrm"
    user     = "alex"
    password = "alexiscool1!"
  }

  provisioner "file" {
    source      = ".\\files\\install_jre.ps1"
    destination = var.target_folder
  }

  provisioner "file" {
    source      = ".\\files\\jre8.exe"
    destination = var.target_folder
  }

  provisioner "remote-exec" {
    connection {
      user     = var.admin_username
      password = var.admin_password
      port     = 5986
      https    = true
      timeout  = "10m"

      # NOTE: if you're using a real certificate, rather than a self-signed one, you'll want this set to `false`/to remove this.
      insecure = true
    }

    inline = [
      "${var.target_folder}\\install_jre.ps1"
      
    ]
  }

}