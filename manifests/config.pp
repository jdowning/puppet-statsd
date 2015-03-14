# == Class: statsd::config
class statsd::config (
  $configfile  = $statsd::configfile,
  $logfile     = $statsd::logfile,
  $statsjs     = "${statsd::node_module_dir}/statsd/stats.js",
  $nodejs_bin  = $statsd::nodejs_bin
) {

  file { '/etc/statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { $statsd::init_location:
    source => $statsd::init_script,
    mode   => $statsd::init_mode,
    owner  => 'root',
    group  => 'root',
  }

  file {  '/etc/default/statsd':
    content => template('statsd/statsd-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/var/log/statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'nobody',
    group  => 'root',
  }

  file { '/usr/local/sbin/statsd':
    source => 'puppet:///modules/statsd/statsd-wrapper',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}
