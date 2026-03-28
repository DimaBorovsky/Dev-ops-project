resource "aws_instance" "ansible-master" {
  ami = "ami-025d7bea93113b6cc"
  instance_type = "t3.micro"
  tags = {
    Name = "ansible-master"
  }
  user_data = "~/Desktop/Dev-ops-project-06/terraform-files/user-data.sh"
  security_groups = [aws_security_group.allow_ssh-ansible-master.id]
}
