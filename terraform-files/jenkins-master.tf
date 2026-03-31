resource "aws_instance" "jenkins-master" {
  instance_type = "t3.micro"
  ami = var.ami
  user_data = "./uesr-data-jenkins.sh"
  tags = {
    Name = "jenkins-master"
  }
  key_name = "ec2-key-2"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_allow_ssh_master.id,aws_security_group.allow_ssh_ansible_master.id,aws_security_group.jenkins_node_allow_master.id]
}