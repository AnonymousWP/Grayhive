# Creates the stages and requirements for each Pipeline

resource "graylog_pipeline" "internalip" {
  source      = var.internal_ip
  description = "Used for Pipelines that only process events with a destination IP field"
}

resource "graylog_pipeline" "normalisation" {
  source      = var.normalise_firewall
  description = "Normalises events from the firewall"  
}
