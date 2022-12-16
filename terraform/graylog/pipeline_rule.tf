# Creates the actual Pipeline rules with its corresponding rules and actions

resource "graylog_pipeline_rule" "internalip" {
  source      = var.internal_ip_rule
  description = "Used for Pipelines that only process events with a destination IP field"
}

resource "graylog_pipeline_rule" "normalisation" {
  source      = var.normalise_firewall_rule
  description = "Normalises events from the firewall"
}
