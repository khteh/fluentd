# fluentd

fluentd container dockerfile deployed as sidecar in kubernetes cluster to ingest logs and push to elasticsearch

## Configuration Validation

To validate fluentd configuration against specific input string, add `@type dummy` into the configuration file:

```
<source>
  @type dummy
  dummy [{"access_log": "[2025-04-04 08:44:16 +0000] [10] [INFO] 192.168.0.149:43472 - - [04/Apr/2025:08:44:16 +0000] \"GET /health/live 2\" 200 2 \"-\" \"kube-probe/1.27\""}]
  tag dummy
</source>
<filter dummy>
  @type parser
  key_name access_log
  reserve_data true
  time_type string
  time_format %Y-%m-%d %H:%M:%S
  keep_time_key true
  # even if we failed to parse the time send the record over to splunk
  emit_invalid_record_to_error false
  reserve_time true
  <parse>
    @type regexp
    expression /^[(?<time>.+?)]\s+[\d{2}]\s+[(?<level>\w+)]\s+(?<ip>[^ ]*)\s+\"(?<method>[A-Z]*) (?<url>[^ ]*)\"\s+(?<code>[^ ]*)\s+(?<size>[^ ]*)\s+(?<duration>[^ ]*)(?<message>.*)$/
  </parse>
</filter>
<source>
  @type dummy
  dummy [{"python_log": "2025-04-04 05:16:07 INFO     Running app..."}]
  tag dummy
</source>
<filter dummy>
  @type parser
  key_name python_log
  reserve_data true
  time_type string
  time_format %Y-%m-%d %H:%M:%S
  keep_time_key true
  # even if we failed to parse the time send the record over to splunk
  emit_invalid_record_to_error false
  reserve_time true
  <parse>
    @type regexp
    expression /^(?<time>.+?)\s+(?<level>\w+)\s+(?<message>.*)$/
  </parse>
</filter>
```

Then, check the configuration:

```
$ fluentd -c /etc/fluent/fluentd.conf --dry-run
```
