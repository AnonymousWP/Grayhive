# Creates a Graylog Stream Rule where the value must be anything you've entered in the console, in the source field.

resource "graylog_stream_rule" "firewall" {
  field       = "source"
  value       = var.streaminput_firewall
  stream_id   = graylog_stream.firewall.id
  description = ""
  type        = 6
  inverted    = false
}
