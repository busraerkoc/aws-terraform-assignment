resource "aws_iam_role" "backup_role" {
  name               = "backup_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "backup_policy_attach" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"

}

resource "aws_iam_role" "web_bucket_role" {
  name               = "web_bucket_role"
  assume_role_policy = data.aws_iam_policy_document.web_sgw_policy.json
}

resource "aws_iam_policy" "web_bucket_policy" {
  name        = "web_bucket_policy"
  description = "Allows access to storage gateway"
  policy      = data.aws_iam_policy_document.web_bucket_policy.json
}

resource "aws_iam_role_policy_attachment" "sgw_polic_attach" {
  role       = aws_iam_role.web_bucket_role.name
  policy_arn = aws_iam_policy.web_bucket_policy.arn
}
