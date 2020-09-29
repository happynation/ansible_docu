resource "aws_instance" "jenkins_terra_ansible" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.jenkins_terra.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_terra_ansible.id]
  
  provisioner "local-exec" {
    command = "sudo echo ${aws_instance.jenkins_terra_ansible.public_ip} >> /var/lib/jenkins/new_inventory"
  }
  provisioner "file" {
    source      = "file.txt"
    destination = "/tmp/file.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +rwx /tmp/file.txt",
      "sudo cat /tmp/file.txt"
    ]
  }
  connection {
    type = "ssh"
    user = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
    host = self.public_ip
  }
}

#  output "instance_ip_addr" {
#    value = aws_instance.jenkins_terra_ansible.public_ip
#  }
