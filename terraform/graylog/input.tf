# Creates a RAW TCP input, Syslog TCP input and Syslog UDP input. All values are default.

resource "graylog_input" "RAW_TCP_Input" {
  title  = "Raw/Plaintext TCP"
  type   = "org.graylog2.inputs.raw.tcp.RawTCPInput"
  global = true

  attributes = jsonencode({
    bind_address              = "0.0.0.0"
    port                      = 5555
    max_message_size          = 2097152
    number_worker_threads     = 4
    override_source           = null
    recv_buffer_size          = 1048576
    tcp_keepalive             = false
    tls_cert_file             = ""
    tls_client_auth           = "disabled"
    tls_client_auth_cert_file = ""
    tls_enable                = false
    tls_key_file              = ""
    tls_key_password          = ""
    use_null_delimiter        = false
  })
}

resource "graylog_input" "Syslog_TCP_Input" {
  title  = "Syslog TCP"
  type   = "org.graylog2.inputs.syslog.tcp.SyslogTCPInput"
  global = true

  attributes = jsonencode({
    bind_address              = "0.0.0.0"
    port                      = 1514
    max_message_size          = 2097152
    number_worker_threads     = 4
    override_source           = null
    recv_buffer_size          = 1048576
    tcp_keepalive             = false
    tls_cert_file             = ""
    tls_client_auth           = "disabled"
    tls_client_auth_cert_file = ""
    tls_enable                = false
    tls_key_file              = ""
    tls_key_password          = ""
    use_null_delimiter        = false
  })
}

resource "graylog_input" "Syslog_UDP_Input" {
  title  = "Syslog UDP"
  type   = "org.graylog2.inputs.syslog.udp.SyslogUDPInput"
  global = true

  attributes = jsonencode({
    bind_address              = "0.0.0.0"
    port                      = 1514
    max_message_size          = 2097152
    number_worker_threads     = 4
    override_source           = null
    recv_buffer_size          = 1048576
    tcp_keepalive             = false
    tls_cert_file             = ""
    tls_client_auth           = "disabled"
    tls_client_auth_cert_file = ""
    tls_enable                = false
    tls_key_file              = ""
    tls_key_password          = ""
    use_null_delimiter        = false
  })
}
