resource "aws_instance" "jenkins-master" {
  instance_type = "t3.micro"
  ami = var.ami
  user_data = "./uesr-data-jenkins.sh"
  tags = {
    name = "jenkins-master"
  }
  security_groups = [aws_security_group.jenkins_allow_ssh-master.id,aws_security_group.allow_ssh-ansible-master.id,aws_security_group.jenkins-node-allow-master.id]
}