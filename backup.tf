resource "aws_backup_vault" "bvault" {
  name = "bvault"
}

resource "aws_backup_plan" "w_backup" {
  name = "oneweek_backup_plan"
  rule {
    rule_name         = "oneweek_backup_plan"
    target_vault_name = aws_backup_vault.bvault.name
    schedule          = "cron(0 12 ? * 1,2,3,4,5,6,7 *)"
    lifecycle {
      delete_after = var.retention_time
    }
  }
}

resource "aws_backup_selection" "ab_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "ab_selection"
  plan_id      = aws_backup_plan.w_backup.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup"
    value = "True"
  }

}
