class statsd::params {
  $graphiteserver   = 'localhost'
  $graphiteport     = '2003'
  $backends         = [ './backends/graphite' ]
  $address          = '0.0.0.0'
  $listenport       = '8125'
  $flushinterval    = '10000'
  $percentthreshold = ['90']
  $ensure           = 'present'
  $provider         = 'npm'
  $config           = { }
  $node_module_dir  = ''

  case $::osfamily {
    'RedHat': {
      $init_script = 'puppet:///modules/statsd/statsd-init-rhel'
      if ! $node_module_dir {
        $statsjs = '/usr/lib/node_modules/statsd/stats.js'
      }
      else {
        $statsjs = "${node_module_dir}/statsd/stats.js"
      }
    }
    'Debian': {
      $init_script = 'puppet:///modules/statsd/statsd-init'
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
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
