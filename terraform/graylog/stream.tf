# Creates a Graylog Stream with the name "Firewall" which gets its logs from the default Stream "All messages"

resource "graylog_stream" "firewall" {
  title         = "Firewall"
  index_set_id  = data.graylog_index_set.default.id
  disabled      = false
  matching_type = "AND"
  description   = "Firewall messages only"
}

data "graylog_stream" "default_stream" {
  title = "Default Stream"
}

data "graylog_index_set" "default" {
  index_prefix = "graylog"
}

data "graylog_stream" "all_events" {
  title = "All events"
}

data "graylog_stream" "all_system_events" {
  title = "All system events"
}
