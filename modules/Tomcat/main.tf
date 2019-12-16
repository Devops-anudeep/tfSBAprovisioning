resource "null_resource" "provision_web" {

  connection {
    host     = var.vm_ipadress
    type     = "winrm"
    user     = "alex"
    password = "alexiscool1!"
  }

  // provisioner "file" {
  //   source      = ".\\files\\install_jre.ps1"
  //   destination = var.target_folder
  // }

  // provisioner "file" {
  //   source      = ".\\files\\jre8.exe"
  //   destination = var.target_folder
  // }

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
      "$URL=(Invoke-WebRequest -UseBasicParsing https://www.java.com/en/download/manual.jsp).Content | %{[regex]::matches($_, '(?:<a title="Download Java software for Windows Online" href=")(.*)(?:">)').Groups[1].Value}",
        "Invoke-WebRequest -UseBasicParsing -OutFile jre8.exe $URL",
        "Start-Process .\jre8.exe '/s REBOOT=0 SPONSORS=0 AUTO_UPDATE=0' -wait",
        "echo $?"
      
    ]
  }

}