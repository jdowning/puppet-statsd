class { 'nodejs': manage_repo => true }->
class { 'statsd':
  backends      => [ './backends/graphite', 'statsd-influxdb-backend' ],
  influxdb_host => 'localhost',
}
