resource "aws_security_group" "allow_ssh-ansible-master" {
  name = "ansible_allow-ssh-all"
  vpc_id = aws_vpc.project-vpc.id
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = aws_subnet.public_subnet.cidr_block
  }
}