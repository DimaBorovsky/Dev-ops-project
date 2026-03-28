resource "aws_instance" "jenkins-node-01" {
  ami = var.ami
  instance_type = "t3.micro"
  tags = {
    Name = "jenkins-worker-01"
  }
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins-node-allow-master.id, aws_security_group.allow_ssh-ansible-master.id]
}


resource "aws_instance" "jenkins-node-02" {
 ami = var.ami
  instance_type = "t3.micro"
  tags = {
    Name = "jenkins-worker-02"
  }
  vpc_security_group_ids = [aws_security_group.jenkins-node-allow-master.id, aws_security_group.allow_ssh-ansible-master.id]
  subnet_id = aws_subnet.public_subnet.id
}