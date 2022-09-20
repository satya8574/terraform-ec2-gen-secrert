output "ec2_arn" {
  value = aws_instance.ec2-server.arn
}
output "ec2_instance_state" {
  value = aws_instance.ec2-server.instance_state
}
output "ec2_public_dns" {
  value = aws_instance.ec2-server.public_dns
}
output "ec2_public_ip" {
  value = aws_instance.ec2-server.public_ip

}
output "aws_private_ip" {

  value = aws_instance.ec2-server.private_ip
}
