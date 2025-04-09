output "jenkins_ec2_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}