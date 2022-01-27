locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  tags = {
    Name             = var.ami_name
    Owner            = var.Owner
    Environment      = var.Environment
    TerraformManaged = false
    IMDSv2           = false
  }
}

source "amazon-ebs" "this" {
  region = var.Region

  ami_name = "${var.ami_name}-${local.timestamp}"
  ami_description = "${var.ami_name}-${local.timestamp}"
  ami_regions = [var.Region]
#  ami_users = var.ami_users

  skip_region_validation = true
  instance_type = var.instance_type

  ssh_timeout        = var.ssh_timeout
  ssh_username       = var.ssh_username

  # for developement env
  force_deregister = true

  encrypt_boot = false
//  kms_key_id   = var.kms_key_id

  vpc_filter {
    filters = {
      "tag:Name": "prod-vpc",
    }
  }

  subnet_filter {
    filters = {
      "tag:Name": "prod-public-sb",
    }
    most_free = true
    random = false
  }

  security_group_filter {
    filters = {
      "tag:Name": "default"
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
    http_put_response_hop_limit = 2
  }

  source_ami_filter {
    filters = {
       virtualization-type = "hvm"
       name = "amzn2-ami-hvm-*-x86_64-ebs"
       root-device-type = "ebs"
    }
    owners = ["amazon"]
    most_recent = true
  }

//  launch_block_device_mappings {
//    device_name = "/dev/sdh"
//    volume_size = "10"
//    volume_type = "gp3"
//    delete_on_termination = true
//  }

  tags = merge(local.tags, { Name = "${var.ami_name}-${local.timestamp}" })
  run_tags = merge(local.tags, { Name = "${var.ami_name}-${local.timestamp}" })
  snapshot_tags = merge(local.tags, { Name = "${var.ami_name}-${local.timestamp}" })

//  temporary_iam_instance_profile_policy_document {
//    Statement {
//        Effect   = "Allow"
//        Action   = ["*"]
//        Resource = ["*"]
//    }
//    Version = "2012-10-17"
//  }
}

build {
  sources = ["source.amazon-ebs.this"]

  provisioner "shell" {
    inline = ["sudo amazon-linux-extras install ansible2 -y"]
  }

  provisioner "ansible-local" {
    playbook_dir  = "playbook"
    playbook_file = "playbook/${var.playbook_file}"
  }

  provisioner "shell" {
    inline = ["rm .ssh/authorized_keys ; sudo rm /root/.ssh/authorized_keys"]
  }
}
