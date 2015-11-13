case $operatingsystem {
  /^(Debian|Ubuntu)$/: { include apt }
  'RedHat', 'CentOS':  { include epel }
}

class { 'nodejs': manage_package_repo => true }->
class { 'statsd':
  backends              => [
    './backends/graphite',
    'statsd-influxdb-backend',
    'statsd-librato-backend',
    'stackdriver-statsd-backend',
    './backends/repeater'
  ],
  graphite_globalSuffix => 'foobar',
  influxdb_host         => 'localhost',
  librato_email         => 'foo@bar.com',
  librato_token         => 'secret_token',
  stackdriver_apiKey    => 'foobar',
  repeater              => [
    {
      'host' => '1.1.1.1',
      'port' => 8215
    }
  ]
}
