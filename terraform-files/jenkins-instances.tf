resource "aws_instance" "jenkins-node-01" {
  ami = var.ami
  associate_public_ip_address = true
  instance_type = "t3.micro"
  tags = {
    Name = "jenkins-worker-01"
  }
  key_name = "ec2-key-2"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_allow_ssh_master.id, aws_security_group.allow_ssh_ansible_master.id]
}


resource "aws_instance" "jenkins-node-02" {
 ami = var.ami
  instance_type = "t3.micro"
  key_name = "ec2-key-2"
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-worker-02"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_allow_ssh_master.id, aws_security_group.allow_ssh_ansible_master.id]
  subnet_id = aws_subnet.public_subnet.id
}