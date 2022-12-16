# Creates two Pipelines gathered from two different Graylog Streams. Both Pipelines have a different purpose.

resource "graylog_pipeline_connection" "internalip" {
  stream_id    = data.graylog_stream.default_stream.id
  pipeline_ids = [graylog_pipeline.internalip.id]
}

resource "graylog_pipeline_connection" "normalisation" {
  stream_id    = graylog_stream.firewall.id
  pipeline_ids = [graylog_pipeline.normalisation.id]
}
