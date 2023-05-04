# Find latest AMI for Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-${var.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create SSH key pair in AWS for login to Bastion host
resource "aws_key_pair" "bastion_ssh_key" {
  key_name   = "three-tier-bastion-ssh-key"
  public_key = var.ssh_public_key
}