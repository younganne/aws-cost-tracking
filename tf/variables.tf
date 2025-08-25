## Terraform Variables

## The name of our budget
variable "budget_name" {
  default = "budget-sandbox-monthly"
}

## Monthly budget alert threshold in USD
variable "cost_limit" {
  default = "1.0"
}

## Preferred email address for receiving budget alerts
variable "email" {
  default = ""
}

## The AWS account ID for this budget
variable "accountID" {
  default = ""
}

### TODO:
### add vars for time period begin and end
