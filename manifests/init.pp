class statsd(
  $graphiteserver,
  $graphiteport     = '2003',
  $address          = '0.0.0.0',
  $listenport       = '8125',
  $flushinterval    = '10000',
  $percentthreshold = ['90'],
  $ensure           = 'present',
  $provider         = 'npm',
) {

  require nodejs

  package { 'statsd':
    ensure   => $ensure,
    provider => $provider,
  }

  $configfile = '/etc/statsd/localConfig.js'
  $logfile    = '/var/log/statsd/statsd.log'

  file {
    '/etc/statsd':
      ensure => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
    $configfile:
      content => template('statsd/localConfig.js.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      require => Package['statsd'];
    '/etc/init.d/statsd':
      source  => 'puppet:///modules/statsd/statsd-init',
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
    '/etc/default/statsd':
      content => template('statsd/statsd-defaults.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
    '/var/log/statsd':
      ensure => directory,
      owner  => 'root',
      group  => 'nogroup',
      mode   => '0770';
    '/usr/local/sbin/statsd':
      source  => 'puppet:///modules/statsd/statsd-wrapper',
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
  }

  service { 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    pattern   => 'node .*stats.js',
    require   => File['/var/log/statsd'],
    subscribe => [
      File['/etc/init.d/statsd'],
      File['/etc/default/statsd'],
      File['/usr/local/sbin/statsd'],
      File[$configfile],
      Package['statsd'],
    ],
  }
}
