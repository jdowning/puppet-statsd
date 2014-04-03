class { 'statsd':
  backends      => [ './backends/graphite', 'statsd-influxdb-backend' ],
  influxdb_host => 'localhost',
}
  exec { 'install-statsd-influxdb-backend':
    command => '/usr/bin/npm install statsd-influxdb-backend',
    cwd     => '/usr/lib/node_modules/statsd',
    unless  => '/usr/bin/test -d /usr/lib/node_modules/statsd/node_modules/statsd-influxdb-backend',
    require => Class['statsd'],
  }
