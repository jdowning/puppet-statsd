# == Class statsd::params
class statsd::params {
  $ensure           = 'present'
  $config           = { }
  $graphite_host    = 'localhost'
  $graphite_port    = '2003'
  $influxdb_host    = ''
  $backends         = [ './backends/graphite' ]
  $address          = '0.0.0.0'
  $listenport       = '8125'
  $flushinterval    = '10000'
  $percentthreshold = ['90']
  $node_module_dir  = ''
  $node_manage      = true
  $node_version     = 'present'

  case $::osfamily {
    'RedHat', 'Amazon': {
      $init_script = 'puppet:///modules/statsd/statsd-init-rhel'
    }
    'Debian': {
      $init_script = 'puppet:///modules/statsd/statsd-init'
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
