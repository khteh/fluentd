# fluentd

fluentd container dockerfile deployed as sidecar in kubernetes cluster to ingest logs and push to elasticsearch

## Configuration Validation

To validate fluentd configuration against specific input string, add `@type sample` into the configuration file:

- https://docs.fluentd.org/input/sample

```
<source>
  @type sample
  sample [{"access_log": "[2025-04-04 08:44:16 +0000] [10] [INFO] 192.168.0.149:43472 - - [04/Apr/2025:08:44:16 +0000] \"GET /health/live 2\" 200 2 \"-\" \"kube-probe/1.27\""}]
  tag access_log_sample
</source>
<filter access_log_sample>
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
      expression /^(?<time>.+?) (?<level>\w{0,8}) (?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>(?:[^\"]|\\.)*?)(?: +\S*)?)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>(?:[^\"]|\\.)*)" "(?<agent>(?:[^\"]|\\.)*)")$/
  </parse>
</filter>
<source>
  @type sample
  sample [{"hypercorn":"[2025-04-06 10:50:12 +0000] [10] [INFO] Running on https://0.0.0.0:443 (QUIC) (CTRL + C to quit)"}]
  tag hypercorn_sample
</source>
<filter hypercorn_sample>
  @type parser
  key_name hypercorn
  reserve_data true
  time_type string
  time_format %Y-%m-%d %H:%M:%S
  keep_time_key true
  # even if we failed to parse the time send the record over to splunk
  emit_invalid_record_to_error false
  reserve_time true
  <parse>
    @type regexp
    expression /^(?<time>.+?) (?<level>\w{0,8}) (?<message>.*)$/
  </parse>
</filter>
```

Then, check the configuration:

```
$ fluentd -c /etc/fluent/fluentd.conf --dry-run
```
