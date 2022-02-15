# Creates a Graylog Stream with the name "Firewall" which gets its logs from the default Stream "All messages"

resource "graylog_stream" "firewall" {
  title         = "Firewall"
  index_set_id  = data.graylog_index_set.default.id
  disabled      = false
  matching_type = "AND"
  description   = "Firewall messages only"
}

data "graylog_stream" "all_messages" {
  title = "All messages"
}

data "graylog_index_set" "default" {
  index_prefix = "graylog"
}
