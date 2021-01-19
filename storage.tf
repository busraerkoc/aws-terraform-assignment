resource "aws_efs_file_system" "application_efs" {
  creation_token = "application-efs"
}
resource "aws_efs_mount_target" "efs_mount" {
  file_system_id  = aws_efs_file_system.application_efs.id
  subnet_id       = aws_subnet.application_sb.id
  security_groups = ["${aws_security_group.sg_efs.id}"]
}

resource "aws_ebs_volume" "sgw_cache_disk" {
  availability_zone = aws_instance.storage_gateway_server.availability_zone
  size              = 150
  type              = "gp2"
}
resource "aws_volume_attachment" "sgw_cache_disk_attach" {
  device_name  = "/dev/xvdb"
  volume_id    = aws_ebs_volume.sgw_cache_disk.id
  instance_id  = aws_instance.storage_gateway_server.id
  force_detach = true
}

resource "aws_s3_bucket" "busra-assignment-bucket" {
  bucket = "busra-assignment-bucket"
  acl    = "private"
}

resource "aws_storagegateway_gateway" "storage_gw" {
  gateway_ip_address = aws_instance.storage_gateway_server.public_ip
  gateway_name       = "storage_gw"
  gateway_timezone   = "GMT"
  gateway_type       = "FILE_S3"
}

data "aws_storagegateway_local_disk" "storage_gw_data" {
  disk_path   = aws_volume_attachment.sgw_cache_disk_attach.device_name
  gateway_arn = aws_storagegateway_gateway.storage_gw.arn
}

resource "aws_storagegateway_cache" "sgw_cache" {
  disk_id     = data.aws_storagegateway_local_disk.storage_gw_data.id
  gateway_arn = aws_storagegateway_gateway.storage_gw.arn
}
resource "aws_storagegateway_nfs_file_share" "nfs_share" {
  client_list  = ["0.0.0.0/0"]
  gateway_arn  = aws_storagegateway_gateway.storage_gw.arn
  location_arn = aws_s3_bucket.busra-assignment-bucket.arn
  role_arn     = aws_iam_role.web_bucket_role.arn
}