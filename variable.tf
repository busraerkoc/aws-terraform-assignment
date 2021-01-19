variable "key_name" {
  type        = string
  description = "SSH key pair name"
  default     = "ssh_key"
}

variable "my_ip" {
  type        = string
  description = "Allowed ip to access the bastion server"
}

variable "retention_time" {
  type        = number
  description = "Retention time for backup"
  default     = 5
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
  default     = "172.31.16.0/21"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public/web subnet cidr"
  default     = "172.31.16.0/24"
}

variable "application_sb_cidr" {
  type        = string
  description = "Private/application subnet cidr"
  default     = "172.31.17.0/24"
}

variable "database_sb_cidr" {
  type        = string
  description = "Private/database subnet cidr"
  default     = "172.31.18.0/24"
}

variable "management_sb_cidr" {
  type        = string
  description = "Private/management subnet cidr"
  default     = "172.31.19.0/24"
}

variable "s3_mount_point" {
  type        = string
  description = "S3 mount point in OS"
  default     = "s3_path"
}

variable "efs_mount_point" {
  type        = string
  description = "EFS mount point in OS"
  default     = "efs_path"
}

variable "web_instance_type" {
  type        = string
  description = "Instance type of web instance"
  default     = "t2.micro"
}

variable "application_instance_type" {
  type        = string
  description = "Instance type of application instance"
  default     = "t2.micro"
}

variable "bastion_instance_type" {
  type        = string
  description = "Instance type of bastion instance"
  default     = "t2.micro"
}

variable "count_web" {
  type        = number
  description = "Number of web instances"
  default     = 1
}
variable "count_app" {
  type        = number
  description = "Number of app instances"
  default     = 1
}
