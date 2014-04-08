# == Class: statsd::config
class statsd::config {
  $configfile  = '/etc/statsd/localConfig.js'
  $logfile     = '/var/log/statsd/statsd.log'
  $statsjs = "${statsd::node_module_dir}/statsd/stats.js"

  # If we have an InfluxDB host, let's install the proper backend
  if $statsd::influxdb_host {
    exec { 'install-statsd-influxdb-backend':
      command => '/usr/bin/npm install --save statsd-influxdb-backend',
      cwd     => "${statsd::node_module_dir}/statsd",
      unless  => "/usr/bin/test -d ${statsd::node_module_dir}/statsd/node_modules/statsd-influxdb-backend",
    }
  }

  file { '/etc/statsd':
    ensure => directory,
    mode   => '0755',
  }->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    mode    => '0644',
  }

  file { '/etc/init.d/statsd':
    source  => $statsd::init_script,
    mode    => '0755',
  }

  file {  '/etc/default/statsd':
    content => template('statsd/statsd-defaults.erb'),
    mode    => '0755',
  }

  file { '/var/log/statsd':
    ensure => directory,
    owner  => 'nobody',
    mode   => '0755',
  }

  file { '/usr/local/sbin/statsd':
    source  => 'puppet:///modules/statsd/statsd-wrapper',
    mode    => '0755',
  }

  File {
    owner  => 'root',
    group  => 'root',
    notify => Service['statsd'],
  }

}
