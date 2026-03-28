resource "aws_security_group" "allow_ssh-ansible-master" {
  name = "ansible_allow-ssh-all"
  vpc_id = aws_vpc.project-vpc.id
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["x.x.x.x/x"]
  }

}


resource "aws_security_group" "jenkins_allow_ssh-master" {
  name = "Jenkins-inbound-ssh"
  vpc_id = aws_vpc.project-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }
}


resource "aws_security_group" "jenkins-node-allow-master" {
  name = "Jenkins-master-to-nodes"
  vpc_id = aws_vpc.project-vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }
}

