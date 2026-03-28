resource "aws_instance" "jenkins-node-01" {
  ami = var.ami
  instance_type = "t3.micro"
  tags = {
    name = "jenkins-worker-01"
  }
  security_groups = [aws_security_group.jenkins-node-allow-master.id, aws_security_group.allow_ssh-ansible-master.id]
}


resource "aws_instance" "jenkins-node-02" {
 ami = var.ami
  instance_type = "t3.micro"
  tags = {
    name = "jenkins-worker-02"
  }
  security_groups = [aws_security_group.jenkins-node-allow-master.id, aws_security_group.allow_ssh-ansible-master.id]
}