class { 'nodejs': manage_repo => true }->
class { 'statsd':
  backends              => [
    './backends/graphite',
    'statsd-influxdb-backend',
    'statsd-librato-backend',
    'stackdriver-statsd-backend'
  ],
  graphite_globalSuffix => 'foobar',
  influxdb_host         => 'localhost',
  librato_email         => 'foo@bar.com',
  librato_token         => 'secret_token',
  stackdriver_apiKey    => 'foobar'
}
