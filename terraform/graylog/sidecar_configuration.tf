# The configuration of the Sidecar, with its corresponding rules and definitions

resource "graylog_sidecar_configuration" "windows" {
  name         = "Windows Collector"
  color        = "#00796b"
  collector_id = graylog_sidecar_collector.windowsfb.id
  template     = var.sidecar_configuration_windows
}

resource "graylog_sidecar_configuration" "linux" {
  name         = "Linux Collector"
  color        = "#00796b"
  collector_id = graylog_sidecar_collector.linuxfb.id
  template     = var.sidecar_configuration_linux
}
