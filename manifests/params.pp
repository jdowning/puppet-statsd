# == Class statsd::params
class statsd::params {
  $ensure           = 'present'
  $port             = '8125'

  $graphiteHost    = 'localhost'
  $graphitePort    = '2003'

  $backends         = [ './backends/graphite' ]
  $debug            = false
  $address          = '0.0.0.0'
  $mgmt_address     = '0.0.0.0'
  $mgmt_port        = '8126'
  $title            = 'statsd'
  $healthStatus     = 'up'
  $dumpMessages     = false
  $flushinterval    = '10000'
  $percentthreshold = ['90']
  $flush_counts     = true

  $influxdb_host    = ''
  $config           = { }

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
