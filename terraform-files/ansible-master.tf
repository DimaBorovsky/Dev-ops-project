resource "aws_instance" "ansible-master" {
  ami = "ami-025d7bea93113b6cc"
  instance_type = "t3.micro"
  tags = {
    Name = "ansible-master"
  }

  user_data =file("./user-data.sh")

}
