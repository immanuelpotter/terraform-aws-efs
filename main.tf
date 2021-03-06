resource "aws_efs_file_system" "this" {
  performance_mode = "${var.performance_mode}"
  tags             = "${var.tags}"
}

resource "aws_efs_mount_target" "private_subnet_a" {
  count           = "${var.private_subnet_a != "" ? 1 : 0}"
  file_system_id  = "${aws_efs_file_system.this.id}"
  subnet_id       = "${var.private_subnet_a}"
  security_groups = ["${var.security_groups}"]
}

resource "aws_efs_mount_target" "private_subnet_b" {
  count           = "${var.private_subnet_b != "" ? 1 : 0}"
  file_system_id  = "${aws_efs_file_system.this.id}"
  subnet_id       = "${var.private_subnet_b}"
  security_groups = ["${var.security_groups}"]
}

resource "aws_efs_mount_target" "private_subnet_c" {
  count           = "${var.private_subnet_c != "" ? 1 : 0}"
  file_system_id  = "${aws_efs_file_system.this.id}"
  subnet_id       = "${var.private_subnet_c}"
  security_groups = ["${var.security_groups}"]
}

data "null_data_source" "values" {
  inputs = {
    volume                        = "${aws_efs_file_system.this.id}"
    dns_name                      = "${aws_efs_file_system.this.dns_name}"
    mount_target_private_subnet_a = "${join(",", aws_efs_mount_target.private_subnet_a.*.id)}"
    mount_target_private_subnet_b = "${join(",", aws_efs_mount_target.private_subnet_b.*.id)}"
    mount_target_private_subnet_c = "${join(",", aws_efs_mount_target.private_subnet_c.*.id)}"
  }
}
