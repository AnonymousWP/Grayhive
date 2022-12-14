# Creates Graylog Alarm Callbacks for sending notifications

resource "graylog_event_notification" "slackfw" {
  description = "Sends notification of firewall to Slack channel"
  title       = "Firewall notification"
  config = jsonencode(
    {
      backlog_size   = 0,
      custom_message = var.custom_event_message # You can change the value in `terraform.tfvars`
      channel        = "#graylog_test",
      color          = "#FF0000"
      icon_emoji     = "",
      icon_url       = var.slack_icon_url # You can change the value in `terraform.tfvars`
      link_names     = false,
      notify_channel = false,
      type           = "slack-notification-v1",
      user_name      = "Graylog",
      webhook_url    = var.slack_webhook # You can change the value in `terraform.tfvars`
    }
  )
}

resource "graylog_event_notification" "slackip" {
  description = "Sends notification of IP-address to Slack channel"
  title       = "IP-address notification"
  config = jsonencode(
    {
      backlog_size   = 0,
      custom_message = var.custom_event_message # You can change the value in `terraform.tfvars`
      channel        = "#graylog-test",
      color          = "#FF0000"
      icon_emoji     = "",
      icon_url       = var.slack_icon_url # You can change the value in `terraform.tfvars`
      link_names     = false,
      notify_channel = false,
      type           = "slack-notification-v1",
      user_name      = "Graylog",
      webhook_url    = var.slack_webhook # You can change the value in `terraform.tfvars`
    }
  )
}

resource "graylog_event_notification" "thehive" {
  count       = (var.enable_the_hive ? 1 : 0)
  description = "Sends notification to The Hive"
  title       = "The Hive"
  config = jsonencode(
    {
      type = "http-notification-v1",
      url  = var.the_hive_uri # You can change the value in `terraform.tfvars`
    }
  )
}
