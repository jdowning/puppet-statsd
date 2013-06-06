class statsd(
  $graphiteserver   = $statsd::params::graphiteserver,
  $graphiteport     = $statsd::params::graphiteport,
  $backends         = $statsd::params::backends,
  $address          = $statsd::params::address,
  $listenport       = $statsd::params::listenport,
  $flushinterval    = $statsd::params::flushinterval,
  $percentthreshold = $statsd::params::percentthreshold,
  $ensure           = $statsd::params::ensure,
  $provider         = $statsd::params::provider,
  $config           = $statsd::params::config,
  $statsjs          = $statsd::params::statsjs,
  $init_script      = $statsd::params::init_script,
) inherits statsd::params {

  require nodejs

  package { 'statsd':
    ensure   => $ensure,
    provider => $provider,
    notify  => Service['statsd'],
  }

  $configfile  = '/etc/statsd/localConfig.js'
  $logfile     = '/var/log/statsd/statsd.log'

  file { '/etc/statsd':
    ensure => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  } ->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['statsd'],
  }
  file { '/etc/init.d/statsd':
    source  => $init_script,
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

  service { 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    pattern   => 'node .*stats.js',
    require   => File['/var/log/statsd'],
  }
}
