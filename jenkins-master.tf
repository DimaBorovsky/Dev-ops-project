resource "aws_instance" "jenkins-master" {
  instance_type = "t3.micro"
  ami = var.ami
  user_data = "./uesr-data-jenkins.sh"
  tags = {
    name = "jenkins-master"
  }
}