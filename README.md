# terraform_k8s_cluster_centos


# Pre requesties -
1- you must have an account who has access to create all resoucres mentioned in playbook.
2- access & secret key should be in .aws/credentials file or if you are using AWS instance to run terraform assign the role (with all resource access).
3- replace the cidr_blocks values in security_group.tf according to your IP range else you can allow for ["0.0.0.0/8"].


ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["103.0.0.0/8","47.9.168.0/24"]
 
