# ==Class: statsd::backends
class statsd::backends {
  # If we have an InfluxDB host, install the proper backend
  if $statsd::influxdb_host {
    exec { 'install-statsd-influxdb-backend':
      command => '/usr/bin/npm install --save statsd-influxdb-backend',
      cwd     => "${statsd::node_module_dir}/statsd",
      unless  => "/usr/bin/test -d ${statsd::node_module_dir}/statsd/node_modules/statsd-influxdb-backend",
      require => Package['statsd'],
    }
  }

  # If we have a Librato token, install the proper backend
  if $statsd::librato_email and $statsd::librato_token {
    exec { 'install-statsd-librato-backend':
      command => '/usr/bin/npm install --save statsd-librato-backend',
      cwd     => "${statsd::node_module_dir}/statsd",
      unless  => "/usr/bin/test -d ${statsd::node_module_dir}/statsd/node_modules/statsd-librato-backend",
      require => Package['statsd'],
    }
  }

  # If we have a stackdriver API key, install the proper backend
  if $statsd::stackdriver_apiKey {
    exec { 'install-statsd-stackdriver-backend':
      command => '/usr/bin/npm install --save stackdriver-statsd-backend',
      cwd     => "${statsd::node_module_dir}/statsd",
      unless  => "/usr/bin/test -d ${statsd::node_module_dir}/statsd/node_modules/stackdriver-statsd-backend",
      require => Package['statsd'],
    }
  }

}
