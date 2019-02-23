resource "aws_iam_role" "s3sqlbackuprole" {
  name_prefix        = "RDSS3_${var.name}_"
  description        = "RDS S3 Backup Restore role for ${var.name}"
  assume_role_policy = "${file("${path.module}/include/assume-role-policy.json")}"

  # https://github.com/terraform-providers/terraform-provider-aws/issues/763#issuecomment-321853149
  provisioner "local-exec" {
    command = "ping 127.0.0.1 -c 11 > nul"
  } 

  tags = {
    "Name" = "${var.name}-rds-iam-role"
    "ids:unit" = "devops"
    "ids:product" = "idscloud"
    "ids:subproduct" = "RDS"
    "ids:owner" = "aherrera@idsgrp.com"
    "ids:env" = "${var.environment_name}"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.name}"
  subnet_ids = ["${var.subnets}"]

  tags = {
    "Name" = "${var.name}-rds-subnet-group"
    "ids:unit" = "devops"
    "ids:product" = "idscloud"
    "ids:subproduct" = "RDS"
    "ids:owner" = "aherrera@idsgrp.com"
    "ids:env" = "${var.environment_name}"
  }
}

resource "aws_db_option_group" "default" {
  name                     = "${var.name}"
  option_group_description = "${var.name}"
  engine_name              = "${var.engine}"
  major_engine_version     = "${var.engine_version_major}"

  option {
    option_name = "SQLSERVER_BACKUP_RESTORE"
  
    option_settings {
      name  = "IAM_ROLE_ARN"
      value = "${aws_iam_role.s3sqlbackuprole.arn}"
    }
  }

  depends_on = [ "aws_iam_role.s3sqlbackuprole" ]

  tags = {
    "Name" = "${var.name}-rds-options-group"
    "ids:unit" = "devops"
    "ids:product" = "idscloud"
    "ids:subproduct" = "RDS"
    "ids:owner" = "aherrera@idsgrp.com"
    "ids:env" = "${var.environment_name}"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage         = "${var.storage}"
  backup_retention_period   = "${var.backup_retention_period}"
  copy_tags_to_snapshot     = "true"
  db_subnet_group_name      = "${aws_db_subnet_group.default.name}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  final_snapshot_identifier = "final-${var.name}"
  identifier_prefix         = "${var.name}-"
  instance_class            = "${var.instance_class}"
  license_model             = "license-included"
  monitoring_interval       = "${var.monitoring_interval}"
  monitoring_role_arn       = "${var.monitoring_role_arn}"
  multi_az                  = "${var.multi_az}"
  option_group_name         = "${aws_db_option_group.default.name}"
  password                  = "${var.password}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  snapshot_identifier       = "${var.restore_snapshot}"
  storage_encrypted         = "true"
  storage_type              = "gp2"
  timezone                  = "${var.timezone}"
  username                  = "${var.username}"
  vpc_security_group_ids    = ["${var.security_groups}"]

  tags = {
    "Name" = "${var.name}-rds-instance"
    "ids:unit" = "devops"
    "ids:product" = "idscloud"
    "ids:subproduct" = "RDS"
    "ids:owner" = "aherrera@idsgrp.com"
    "ids:env" = "${var.environment_name}"
  }
}
