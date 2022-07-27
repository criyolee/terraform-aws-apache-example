
# data "aws_vpc" "my_vpc" {
#   id = var.vpc_id
# }


# module "ec2_apache" {

#     source = ".//ec2_apache"
    
#     public_key = var.public_key
#     vpc_id = var.vpc_id
#     sg_name = var.sg_name
#     http_port = var.http_port
#     ssh_port = var.ssh_port
#     my_ip = var.my_ip
#     ami = var.ami
#     instance_type = var.instance_type
#     connection_type = var.connection_type
#     ec2_user = var.ec2_user
#     server_name = var.server_name

# }

module "ec2_apache" {

    source = "..//ec2_apache"
    
    env = "dev"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL86fLrkTKF9tGRi0fpecHLKnmDRKm9STtwD5cEAdhy96eg9+Gq7t8CjbJ4lZ8gkdvWhgn6EI84gHuc2l2X9exm1l1R2PnqDuATGn/QSzl1qLEIFZEhyPXJOXaIaHsgMhHk95km5MVb4NiCwEN6x/YvFlumE03CINs1kGjnljY2WBAcE2DDnB4xgEBqvzUtxqW5Nxqw1yqIUBNuBghvcro/FdVI2y2P/5I1FLeJsBxbdUZVwOzCTUt6Mjg2Z+4LyFCReG7UNXGoubFc/RVC+QTTTV/DFvSZoZiiBEgNLap9IdzUEJ6MCJevZwt1g2BcYX3PuHN0ZWQZ+dZUWCex/Ug30Bob2epSbR79gA3wSAN2uKHa/FtjLSwmpjncZl7XwURG7OC11OwT/NieNb8iVr8nj3v8QowoAFa+qZnUELAMkyPx54ZOeSWjKif82EgWtDazx0aBvID4hLCNLGyChvAuG2VyBhQcxORJ3yYN7RULyAgjejdgQbFcyhcubRUm3c= criyo@ThinkBook"
    vpc_id = "vpc-431d753e"
    sg_name = "sg_allow_ssh_dev"
    http_port = "80"
    ssh_port = "22"
    my_ip = "51.186.137.22/32"
    ami = "ami-0cff7528ff583bf9a"
    instance_type = "t2.nano"
    connection_type = "ssh"
    ec2_user = "ec2-user"
    server_name = "MyProvisionerInstance_dev"
    ssh_private_key = "C:\\Users\\criyo\\.ssh\\id_rsa"

}


output "ip_addr" {
  value = module.ec2_apache.public_ip
}