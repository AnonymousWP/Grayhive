# Creates the actual GROK patterns

resource "graylog_grok_pattern" "session_created" {
  name    = "SESSION_CREATED"
  pattern = var.grok_pattern_session_created
}

resource "graylog_grok_pattern" "session_denied" {
  name    = "SESSION_DENIED"
  pattern = var.grok_pattern_session_denied
}
