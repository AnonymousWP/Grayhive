# Creates an extractor that extracts the incoming messages and uses the GROK pattern to format it

resource "graylog_extractor" "grok_session_created" {
  input_id        = graylog_input.Syslog_UDP_Input.id
  title           = "GROK pattern session created"
  type            = "grok"
  cursor_strategy = "copy"
  source_field    = "message"
  target_field    = "none"
  condition_type  = "string"
  condition_value = "RT_FLOW_SESSION_CREATE"
  order           = 0

  extractor_config = jsonencode({
    grok_pattern = "%%{SESSION_CREATED}"
  })
}

resource "graylog_extractor" "grok_session_denied" {
  input_id        = graylog_input.Syslog_UDP_Input.id
  title           = "GROK pattern session denied"
  type            = "grok"
  cursor_strategy = "copy"
  source_field    = "message"
  target_field    = "none"
  condition_type  = "string"
  condition_value = "RT_FLOW_SESSION_DENIED"
  order           = 0

  extractor_config = jsonencode({
    grok_pattern = "%%{SESSION_DENIED}"
  })
}
