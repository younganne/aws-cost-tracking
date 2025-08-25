# AWS-cost-tracking

## AWS cost tracking, alerting, and reporting

A Cloudformation template that creates an AWS budget and sends out both email and Slack alerts in the following scenarios:

- Forecasted costs exceed 100% of budget.
- Actual costs exceed 90% of budget.

To deploy cost tracking to a new AWS Account, complete the following steps in order:

### Giving Github Actions Access to an AWS Account

The cost tracking logic is contained in a cloudformation template that is deployed via a github action. This requires the github action to have (limited) access to each AWS account the cost tracking logic is deployed to. To provide this access, follow these steps:

1. Log into the target AWS account as an admin user.
2. Go to the US West cloudformation console: https://us-west-2.console.aws.amazon.com/cloudformation/
3. Click `Create New Stack -> With New Resources (standard)`
4. Choose `Upload a template file` and select the `github-oidc-cost-tracking-cfn.yaml` file from this repo. Click `Next`
5. For the stack name, enter `IcsiItGithubOidcIntegration-CostTracking`. Click `Next`
6. For `Configure stack options` - Leave the defaults in place, and click `Next`
7. For `Review and create` - Review the selections, check the IAM checkbox at the end, and click `Submit`. The stack will take few minutes to create.

Now Github Actions run in this repo will assume the AWS IAM Role as defined in the [github-oidc-cost-tracking-cfn.yaml](github-oidc-cost-tracking-cfn.yaml) file.

For more details, see: https://github.com/aws-actions/configure-aws-credentials

### Adding New AWS Account to Github Actions Configuration

The github action that deploys/updates the cost tracking cloudformation needs to be aware of which accounts to deploy to, and any specific configuration for those accounts.

Configure Slack webhook URLS.

When adding a new account, updating the [deploy-cost-tracking-cfn.yaml](.github/workflows/deploy-cost-tracking-cfn.yaml) file in this repo with a new array in the matrix include config.

Per ICSI regulations, emails and slack webhook URLS should be treated as secrets, and stored in Github as such. Note that github secrets cannot be viewed again once stored. If the value will be needed to be referenced in the future, it should be also stored in a dedicated credentials manager (such as Bitwarden)

```yaml
          - aws_account_id: <AWS Account ID. REQUIRED.>
            aws_account_name: <Name to describe the AWS account. This will be used in the Slack alerts. REQUIRED.>
            aws_account_email_1: <Github secret name of email address to send alerts to. REQUIRED.>
            aws_account_email_2: <Github secret name of second email address to send alerts to. REQUIRED.>
            slack_webhook_url_1: <Github secret name of slack webhook URL to deliver alerts to. REQUIRED.>
            slack_webhook_url_2: <Github secret name of slack webhook URL to deliver alerts to. REQUIRED.>
            budget_cost_limit: <The cost limit (USD) - when breached, an alert will be sent.>
```

When this change is committed to the main branch and pushed, it will automatically be deployed to the new account.
