# == Class: statsd::config
class statsd::config {
  $configfile  = '/etc/statsd/localConfig.js'
  $logfile     = '/var/log/statsd/statsd.log'

  if ! $statsd::node_module_dir {
    $statsjs = '/usr/lib/node_modules/statsd/stats.js'
  }
  else {
    $statsjs = "${statsd::node_module_dir}/statsd/stats.js"
  }

  file { '/etc/statsd':
    ensure => directory,
    mode   => '0755',
  }->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    mode    => '0444',
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
    mode   => '0770',
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
