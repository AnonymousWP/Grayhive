variable "authpassword" {
  description = "Authorisation password for Graylog Provider module"
  type        = string
}

variable "authusername" {
  description = "Authorisation username for Graylog Provider module"
  type        = string
}

variable "streaminput_firewall" {
  description = "Stream input for the source"
  type        = string
}

variable "streaminput_ip_address" {
  description = "Stream input for the source"
  type        = string
}

variable "custom_event_message" {
  description = "Custom Event Notification Message"
  type        = string
}

variable "slack_webhook" {
  description = "Webhook used to send events to Slack"
  type        = string
}

variable "sidecar_configuration_linux" {
  description = "Sidecar Linux template content"
  type        = string
}

variable "sidecar_configuration_windows" {
  description = "Sidecar Windows template content"
  type        = string
}

variable "slack_icon_url" {
  description = "The icon URL for the message in Slack"
  type        = string
}

variable "internal_ip" {
  description = "For the Pipeline initial configuration"
  type        = string
}

variable "internal_ip_rule" {
  description = "Used for Pipelines that only process events with a destination IP field"
  type        = string
}

variable "normalise_firewall" {
  description = "For the Pipeline initial configuration"
  type        = string
}

variable "normalise_firewall_rule" {
  description = "Normalises events from the firewall"
  type        = string
}
variable "grok_pattern_session_created" {
  description = "GROK pattern for 'session created'"
  type        = string
}

variable "grok_pattern_session_denied" {
  description = "GROK pattern for 'session denied'"
  type        = string
}

variable "the_hive_uri" {
  description = "URI of HTTP alert, which is the IP-address of the Graylog Docker container"
  type        = string
}

variable "enable_the_hive" {
  description = <<EOT
    (Optional) Enable The Hive module.
  EOT
  type        = bool
}
