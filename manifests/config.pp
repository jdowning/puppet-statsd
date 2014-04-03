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
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['statsd'],
  }
  file { '/etc/init.d/statsd':
    source  => $statsd::init_script,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['statsd'],
  }
  file {  '/etc/default/statsd':
    content => template('statsd/statsd-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['statsd'],
  }
  file { '/var/log/statsd':
    ensure => directory,
    owner  => 'nobody',
    group  => 'root',
    mode   => '0770',
  }
  file { '/usr/local/sbin/statsd':
    source  => 'puppet:///modules/statsd/statsd-wrapper',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['statsd'],
  }
}
