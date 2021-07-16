resource "aws_instance" "master-server" {
  count = "${var.master_instance_count}"
  ami           = "${lookup(var.AMIS, var.aws_region)}"
  instance_type = "${var.server_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.k8s-profile.name}"
  #count  = "${length(aws_subnet.k8s-subnet.*.id)}"
  subnet_id = "${element(aws_subnet.k8s-subnet.*.id, count.index)}"
  vpc_security_group_ids =  ["${aws_security_group.k8s-security-group.id}"]
  key_name = "${aws_key_pair.k8s-cluster-key.key_name}"
  tags = {
          Name = "master-server-${count.index + 1}"
         }
   
    provisioner "file" {
    source      = "kubernetes.repo"
    destination = "/tmp/kubernetes.repo"


    connection {
      type     = "ssh"
      user     = "ec2-user"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }
    }

    provisioner "file" {
    source      = "k8smaster_script.sh"
    destination = "/tmp/k8smaster_script.sh"

    
    connection {
      type     = "ssh"
      user     = "ec2-user"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }
    }

    provisioner "file" {
    source      = "k8s.conf"
    destination = "/tmp/k8s.conf"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }
  }

 provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/k8smaster_script.sh",
      "/tmp/k8smaster_script.sh",
    ]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }

  }

  timeouts {
    create = "10m"
    }

  depends_on = [aws_key_pair.k8s-cluster-key]
}

resource "aws_instance" "client-server" {
  count = "${var.node_instance_count}"
  ami           = "${lookup(var.AMIS, var.aws_region)}"
  instance_type = "${var.client_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.k8s-profile.name}"
  #count  = "${length(aws_subnet.k8s-subnet.*.id)}"
  subnet_id = "${element(aws_subnet.k8s-subnet.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.k8s-security-group.id}"]
  key_name = "${aws_key_pair.k8s-cluster-key.key_name}"
  tags = {
          Name = "client-server-${count.index + 1}"
         }
  
    provisioner "file" {
    source      = "k8sclient_script.sh"
    destination = "/tmp/k8sclient_script.sh"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }
    }

    provisioner "file" {
    source      = "kubernetes.repo"
    destination = "/tmp/kubernetes.repo"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }
    }

    provisioner "file" {
    source      = "k8s.conf"
    destination = "/tmp/k8s.conf"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }
    }

 provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/k8sclient_script.sh",
      "/tmp/k8sclient_script.sh",
    ]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = tls_private_key.sshkeys.private_key_pem
      host     = "${self.public_ip}"
      }

   }


  depends_on = [aws_key_pair.k8s-cluster-key, aws_instance.master-server]
}
