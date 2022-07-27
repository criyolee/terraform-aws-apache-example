
output "public_ip" {
  value = aws_instance.MyProvisionerInstance.public_ip
}
