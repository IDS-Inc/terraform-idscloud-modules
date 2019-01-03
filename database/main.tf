resource "aws_iam_role" "s3sqlbackuprole" {
  name_prefix        = "RDSS3_${var.name}_"
  description        = "RDS S3 Backup Restore role for ${var.name}"
  assume_role_policy = "${file("${path.module}/include/assume-role-policy.json")}"

  # https://github.com/terraform-providers/terraform-provider-aws/issues/763#issuecomment-321853149
  provisioner "local-exec" {
    command = "ping 127.0.0.1 -c 11 > nul"
  } 
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.name}"
  subnet_ids = ["${var.subnets}"]
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
}

resource "aws_db_instance" "default" {
  allocated_storage         = "${var.storage}"
  storage_type              = "gp2"
  storage_encrypted         = "true"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  identifier_prefix         = "${var.name}-"
  instance_class            = "${var.instance_class}"
  username                  = "${var.username}"
  password                  = "${var.password}"
  backup_retention_period   = "${var.backup_retention_period}"
  final_snapshot_identifier = "final-${var.name}"
  db_subnet_group_name      = "${aws_db_subnet_group.default.name}"
  vpc_security_group_ids    = ["${var.security_groups}"]
  option_group_name         = "${aws_db_option_group.default.name}"
  timezone                  = "${var.timezone}"

  #  deletion_protection = true
  multi_az      = "${var.multi_az}"
  license_model = "license-included"
}
