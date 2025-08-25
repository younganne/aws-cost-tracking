## Terraform Budget template

## Monthly AWS costs budget in USD
resource "aws_budgets_budget" "cost" {
  name              = var.budget_name
  budget_type       = "COST"
  limit_amount      = var.cost_limit
  limit_unit        = "USD"
  time_period_end   = "2025-02-28_00:00"
  time_period_start = "2024-02-29_14:00"
  time_unit         = "MONTHLY"

  ## Alert when actual cost exceeds 90% of budget
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 90
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.email
  }

  ## Alert when actual cost exceeds 100% of budget
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.email
  }

  ## Alert when forecasted cost exceeds 100% of budget
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.email
  }
}
