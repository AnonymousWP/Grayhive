# Creates two Graylog Sidecars: a Sidecar collector for both Linux and Windows with their corresponding executable paths.

resource "graylog_sidecar_collector" "linuxfb" {
  name                  = "linux_filebeat"
  service_type          = "exec"
  node_operating_system = "linux"
  executable_path       = "/usr/share/filebeat/bin/filebeat"
}

resource "graylog_sidecar_collector" "windowsfb" {
  name                  = "windows_filebeat"
  service_type          = "exec"
  node_operating_system = "windows"
  executable_path       = "C:\\Program Files\\Graylog\\sidecar\\filebeat.exe"
}
