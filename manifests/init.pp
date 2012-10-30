class statsd(
  $graphiteserver = 'graphite.dc1.puppetlabs.net',
  $graphiteport   = '2003',
  $listenport     = '8125'
) {

  # Unstable repo has nodejs in it!
  include apt::debian::unstable

  package{
    'nodejs':;
    'statsd':
      require => Package['nodejs'];
  }


  # This will get moved off at one point I am sure.
  file{
    '/etc/statsd/rdioConfig.js':
      content => "{ graphitePort: ${graphiteport} , graphiteHost: \"${graphiteserver}\" , port: ${listenport} }",
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      require => Package['statsd'];
    '/etc/init.d/statsd':
      source  => 'puppet:///modules/statsd/statsdinitscript',
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

  service{ 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    pattern   => 'node .*stats.js',
    require   => [ File['/etc/init.d/statsd'], File['/etc/init.d/statsd'], File['/var/log/statsd'], ]
  }
}
