# == Class: statsd::config
class statsd::config {
  $configfile  = '/etc/statsd/localConfig.js'
  $logfile     = '/var/log/statsd/statsd.log'
  $statsjs = "${statsd::node_module_dir}/statsd/stats.js"

  file { '/etc/statsd':
    ensure => directory,
    mode   => '0755',
  }->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    mode    => '0644',
  }

  file { $statsd::init_location:
    source  => $statsd::init_script,
    mode    => $statsd::init_mode,
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
