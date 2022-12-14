# Creates a Graylog Event Definition named "Firewall" and "IP-address", a priority 

resource "graylog_event_definition" "firewall" {
  title       = "Firewall"
  description = ""
  priority    = 2
  alert       = true

  # Condition type is "Filter & Aggregation" and it filters on the variable described in `terraform.tfvars`. Gets its results from the Firewall Stream.

  config = jsonencode({
    type             = "aggregation-v1"
    query            = var.streaminput_firewall
    query_parameters = []
    streams = [
      "${graylog_stream.firewall.id}"
    ],
    search_within_ms = 60000
    execute_every_ms = 60000
    group_by         = []
    series           = []
    conditions = {
      expression = null
    }
  })

  field_spec = null

  key_spec = null

  # For creating a webhook with notifications being sent to Slack, see: https://api.slack.com/messaging/webhooks

  notification_settings {
    grace_period_ms = 60000
    backlog_size    = 1
  }

  notifications {
    notification_id = graylog_event_notification.slackfw.id
  }
}

resource "graylog_event_definition" "ip_address" {
  title       = "IP-address"
  description = ""
  priority    = 1
  alert       = true

  # Condition type is "Filter & Aggregation" and it filters on the variable described in `terraform.tfvars`. Gets its results from the Firewall Stream.


  config = jsonencode({
    type             = "aggregation-v1"
    query            = var.streaminput_ip_address
    query_parameters = []
    streams = [
      "${graylog_stream.firewall.id}"
    ],
    search_within_ms = 60000
    execute_every_ms = 60000
    group_by         = []
    series           = []
    conditions = {
      expression = null
    }
  })

  field_spec = null

  key_spec = null

  # For creating a webhook with notifications being sent to Slack, see: https://api.slack.com/messaging/webhooks

  notification_settings {
    grace_period_ms = 60000
    backlog_size    = 1
  }

  notifications {
    notification_id = graylog_event_notification.slackip.id
  }
}
