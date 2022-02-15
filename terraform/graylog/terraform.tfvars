authusername = "admin"

slack_webhook = ""

streaminput_firewall = ""

streaminput_ip_address = ""

custom_event_message = <<EOT
    --- *[Event Definition]* ---------------------------

    *Title:*       _$${event_definition_title}_
    *Type:*        _$${event_definition_type}_

    --- *[Event]* --------------------------------------

    *Timestamp:*            _$${event.timestamp}_
    *Message:*              _$${event.message}_
    *Source:*               _$${event.source}_
    *Key:*                   $${event.key}
    *Priority:*             _$${event.priority}_
    *Alert:*                _$${event.alert}_
    *Timestamp Processing:* _$${event.timestamp}_
    *Timerange Start:*       $${event.timerange_start}
    *Timerange End:*         $${event.timerange_end}
    *Event Fields:*
    $${foreach event.fields field}
    _*$${field.key}:* $${field.value}_
    $${end}
    $${if backlog}

    --- *[Backlog]* ------------------------------------

    *Last messages accounting for this alert:*
    $${foreach backlog message}
    _$${message.timestamp}  ::  $${message.source}  ::  $${message.message}_
    $${end}$${end}
EOT

sidecar_configuration_linux = <<EOT
# Needed for Graylog
fields_under_root: true
fields.collector_node_id: $${sidecar.nodeName}
fields.gl2_source_collector: $${sidecar.nodeId}

filebeat.inputs:
- input_type: log
  paths:
    - /var/log/*.log
  type: log
output.logstash:
  hosts: [""]
path:
  data: /var/lib/graylog-sidecar/collectors/filebeat/data
  logs: /var/lib/graylog-sidecar/collectors/filebeat/log
EOT

sidecar_configuration_windows = <<EOT
# Needed for Graylog
fields_under_root: true
fields.collector_node_id: $${sidecar.nodeName}
fields.gl2_source_collector: $${sidecar.nodeId}
output.logstash:
  hosts: [""]
path:
  data: C:\Program Files\Graylog\sidecar\cache\filebeat\data
  logs: C:\Program Files\Graylog\sidecar\logs
tags:
- windows
filebeat.inputs:
- type: log
  enabled: true
  paths:
  - C:\logs\log.log
EOT

slack_icon_url = "https://symbols.getvecta.com/stencil_82/74_graylog-icon.52dfa55696.svg"

internal_ip = <<EOF
pipeline "Internal IP"
  stage 0 match either rule "enrichment_rfc1918_src_ip"
end
EOF

internal_ip_rule = <<EOF
rule "enrichment_rfc1918_src_ip"
when
    // only process events with a src_ip field
    has_field("src_ip")
    AND
    // check if rfc1918, only one of these must be true
    ( 
        cidr_match("10.0.0.0/8", to_ip($message.src_ip))
        OR
        cidr_match("172.16.0.0/12", to_ip($message.src_ip))
        OR
        cidr_match("192.168.0.0/16", to_ip($message.src_ip))
        OR
        cidr_match("127.0.0.0/8", to_ip($message.src_ip))
    )
then
	set_field("src_ip_is_internal", true);
end
EOF

normalise_firewall = <<EOF
pipeline "Normalisation firewall"
  stage 0 match either rule "normalise_juniper"
end
EOF

normalise_firewall_rule = <<EOF
rule "normalise_juniper"
when
    // only run this rule on events with event_type:junos
    has_field("event_type") AND 
    contains(to_string($message.event_type), "junos")
then
    rename_field("appcat", "category"); // used in application logs
    rename_field("catdesc", "category"); // used in url logs
    rename_field("srcip", "src_ip");
    rename_field("srcport", "src_port");
    rename_field("logdesc", "event_desc");
    rename_field("dstip", "dst_ip");
    rename_field("dstport", "dst_port");

    remove_field("geoip_city_name"); // remove in favour of our own geoip data
    remove_field("geoip_continent_code");
    remove_field("geoip_country_code2");
    remove_field("geoip_country_code3");
    remove_field("geoip_country_name");

    set_field("event_type", "firewall");
end
EOF

grok_pattern_session_created = "(%%{WORD:filteraction}): (%%{DATA:description}) (%%{IP:src_ip})/(%%{NUMBER:src_port})(\\-\\>)(%%{IP:dst_ip})/(%%{NUMBER:dst_port}) (%%{DATA:connection_tag}) (%%{DATA:service_name}) (%%{IP:nat_src_ip})/(%%{NUMBER:nat_src_port})(\\-\\>)(%%{IP:nat_dst_ip})/(%%{NUMBER:nat_dst_port}) (%%{DATA:nat_connection_tag}) (%%{DATA:src_nat_rule_type}) (%%{DATA:src_nat_rule_name}) (%%{DATA:dst_nat_rule_type}) (%%{DATA:dst_nat_rule_name}) (%%{NUMBER:proto_number}) (%%{DATA:fw_rule}) (%%{DATA:src_zone}) (%%{DATA:dst_zone}) (%%{DATA:session_id_32}) (%%{DATA:username_role}) (%%{DATA:interface}) (%%{DATA:application}) (%%{DATA:nested_application}) (%%{GREEDYDATA:endmessage})"

grok_pattern_session_denied = "(%%{WORD:filteraction}): (%%{DATA:description}) (%%{IP:src_ip})/(%%{NUMBER:src_port})(\\-\\>)(%%{IP:dst_ip})/(%%{NUMBER:dst_port}) (%%{DATA:connection_tag}) (%%{DATA:service_name}) (%%{DATA:proto_number}) (%%{DATA:fw_rule}) (%%{DATA:src_zone}) (%%{DATA:dst_zone}) (%%{DATA:application}) (%%{DATA:nested_application}) (%%{DATA:username_role}) (%%{DATA:interface}) (%%{DATA:session_id_32}) (%%{GREEDYDATA:application_category})"

the_hive_uri = ""

enable_the_hive = true
