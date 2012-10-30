class statsd(
  $graphiteserver,
  $graphiteport     = '2003',
  $address          = '0.0.0.0',
  $listenport       = '8125',
  $flushinterval    = '10000',
  $percentthreshold = ['90'],
) {

  require nodejs

  package { 'statsd': ensure => present, }


  file {
    '/etc/statsd/rdioConfig.js':
      content => template('statsd/rdioConfig.js.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      require => Package['statsd'];
    '/etc/init.d/statsd':
      source  => 'puppet:///modules/statsd/statsd-init',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['statsd'];
    '/var/log/statsd':
      ensure => directory,
      owner  => 'root',
      group  => 'nogroup',
      mode   => '0770',
  }

  service { 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    pattern   => 'node .*stats.js',
    require   => [
      File['/etc/init.d/statsd'],
      File['/etc/init.d/statsd'],
      File['/var/log/statsd'],
    ],
  }
}
