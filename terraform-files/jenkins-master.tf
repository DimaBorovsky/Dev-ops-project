resource "aws_instance" "jenkins-master" {
  instance_type = "t3.micro"
  ami = var.ami
  user_data = "./uesr-data-jenkins.sh"
  tags = {
    Name = "jenkins-master"
  }
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_allow_ssh-master.id,aws_security_group.allow_ssh-ansible-master.id,aws_security_group.jenkins-node-allow-master.id]
}