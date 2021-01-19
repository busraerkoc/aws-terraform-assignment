data "template_file" "userdata_web" {
  template = file("${path.module}/templates/userdata_web.sh.tpl")
  vars = {
    os_mount_point  = var.s3_mount_point
    sgw_ip          = aws_instance.storage_gateway_server.private_ip
    sgw_export_path = aws_storagegateway_nfs_file_share.nfs_share.path
  }
}

data "template_file" "userdata_application" {
  template = file("${path.module}/templates/userdata_app.sh.tpl")
  vars = {
    os_mount_point   = var.efs_mount_point
    efs_mount_target = "${aws_efs_file_system.application_efs.id}.efs.eu-central-1.amazonaws.com"
  }
}