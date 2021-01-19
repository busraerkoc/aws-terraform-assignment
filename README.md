## Requirements

- terraform version 12
- aws profile

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| template | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_instance\_type | Instance type of application instance | `string` | `"t2.micro"` | no |
| application\_sb\_cidr | Private/application subnet cidr | `string` | `"172.31.17.0/24"` | no |
| bastion\_instance\_type | Instance type of bastion instance | `string` | `"t2.micro"` | no |
| count\_app | Number of app instances | `number` | `1` | no |
| count\_web | Number of web instances | `number` | `1` | no |
| database\_sb\_cidr | Private/database subnet cidr | `string` | `"172.31.18.0/24"` | no |
| efs\_mount\_point | EFS mount point in OS | `string` | `"efs_path"` | no |
| key\_name | SSH key pair name | `string` | `"ssh_key"` | no |
| management\_sb\_cidr | Private/management subnet cidr | `string` | `"172.31.19.0/24"` | no |
| my\_ip | Allowed ip to access the bastion server | `string` | n/a | yes |
| public\_subnet\_cidr | Public/web subnet cidr | `string` | `"172.31.16.0/24"` | no |
| retention\_time | Retention time for backup | `number` | `5` | no |
| s3\_mount\_point | S3 mount point in OS | `string` | `"s3_path"` | no |
| vpc\_cidr\_block | CIDR block for VPC | `string` | `"172.31.16.0/21"` | no |
| web\_instance\_type | Instance type of web instance | `string` | `"t2.micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_instance\_private\_ip | n/a |
| bastion\_public\_ip | n/a |
| information\_to\_connect\_bastion | n/a |
| web\_instance\_public\_ip | n/a |


## Usage

```
terraform init

terraform plan

terraform apply

terraform destroy
```