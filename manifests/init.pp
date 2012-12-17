class statsd(
  $graphiteserver   = 'localhost',
  $graphiteport     = '2003',
  $backends         = [ 'graphite' ],
  $address          = '0.0.0.0',
  $listenport       = '8125',
  $flushinterval    = '10000',
  $percentthreshold = ['90'],
  $ensure           = 'present',
  $provider         = 'npm',
  $config           = { },
  $node_module_dir  = '',
) {

  require nodejs

  package { 'statsd':
    ensure   => $ensure,
    provider => $provider,
  }
  
  if ! $node_module_dir {
    case $provider {
      'apt': {
        $statsjs = '/usr/share/statsd/stats.js'
      }
      'npm': {
        $statsjs = '/usr/lib/node_modules/statsd/stats.js'
      }
      default: {
        fail('Unsupported provider')
      }
    }
  }
  else {
    $statsjs = "${node_module_dir}/statsd/stats.js"
  }

  $configfile = '/etc/statsd/localConfig.js'
  $logfile    = '/var/log/statsd/statsd.log'
  
  case $::osfamily {
    'RedHat': {
      $init_script = 'puppet:///modules/statsd/statsd-init-rhel'
    }
    'Debian': {
      $init_script = 'puppet:///modules/statsd/statsd-init'
    }
    default: {
      fail('Unsupported OS Family')
    }
  }

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
      source  => $init_script,
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
      group  => 'root',
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
    hasstatus => true,
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
