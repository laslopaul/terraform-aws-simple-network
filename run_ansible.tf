locals {
  bastion_ip  = module.aws-three-tier-compute.bastion_public_ip
  external_lb = module.aws-three-tier-loadbalancer.external_lb_endpoint
  internal_lb = module.aws-three-tier-loadbalancer.internal_lb_endpoint
  db_host     = module.aws-three-tier-db.db_hostname
  db_user     = module.aws-three-tier-db.db_username
  db_password = module.aws-three-tier-db.db_password
}

resource "null_resource" "run_ansible" {
  triggers = {
    always_run = timestamp()
  }

  connection {
    type        = "ssh"
    host        = local.bastion_ip
    user        = "ubuntu"
    private_key = file("./.ssh/bastion")
  }

  provisioner "remote-exec" {
    inline = [
      "cd ~/terraform-aws-three-tier-arch/ansible",
      "git pull",
      <<-EOT
      ansible-playbook \
        -e external_lb=${local.external_lb} \
        -e internal_lb=${local.internal_lb} \
        -e db_host=${local.db_host} \
        -e db_user=${local.db_user} \
        -e db_password=${local.db_password} playbook.yml
      EOT
    ]
  }
}
