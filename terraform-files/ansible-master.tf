resource "aws_instance" "ansible-master" {
  ami = "ami-025d7bea93113b6cc"
  instance_type = "t3.micro"
  tags = {
    Name = "ansible-master"
  }
  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet.id
  user_data = "./user-data.sh"
  vpc_security_group_ids = [aws_security_group.allow_ssh_ansible_master.id]
  key_name = "ec2-key-2"
}
