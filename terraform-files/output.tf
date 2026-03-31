
output "public_ip" {
  value = aws_instance.ansible-master.public_ip
}

output "public_ip-jenkins" {
  value = aws_instance.jenkins-master.public_ip
}


output "public_ip-node-1" {
  value = aws_instance.jenkins-node-02.public_ip
}

output "public_ip-node-2" {
  value = aws_instance.jenkins-node-02.public_ip
}

output "private-master-ip" {
  value = aws_instance.jenkins-master.private_ip
}


output "private-jenkis-node-01" {
  value = aws_instance.jenkins-node-01.private_ip
}


output "private-jenkis-node-02" {
  value = aws_instance.jenkins-node-02.private_ip
}
