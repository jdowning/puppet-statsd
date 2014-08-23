# == Class statsd::params
class statsd::params {
  $ensure                            = 'present'
  $node_module_dir                   = '/usr/lib/node_modules'

  $port                              = '8125'
  $address                           = '0.0.0.0'

  $backends                          = [ './backends/graphite' ]
  $debug                             = false
  $mgmt_address                      = '0.0.0.0'
  $mgmt_port                         = '8126'
  $statsd_title                      = 'statsd'
  $healthStatus                      = 'up'
  $dumpMessages                      = false
  $flushInterval                     = '10000'
  $percentThreshold                  = ['90']
  $flush_counts                      = true

  $graphiteHost                      = 'localhost'
  $graphitePort                      = '2003'
  $graphite_legacyNamespace          = true
  $graphite_globalPrefix             = 'stats'
  $graphite_prefixCounter            = 'counters'
  $graphite_prefixTimer              = 'timers'
  $graphite_prefixGauge              = 'gauges'
  $graphite_prefixSet                = 'sets'
  $graphite_globalSuffix             = ''

  $influxdb_host                     = undef
  $influxdb_port                     = '8086'
  $influxdb_database                 = 'statsd'
  $influxdb_username                 = 'root'
  $influxdb_password                 = 'root'
  $influxdb_flush                    = true
  $influxdb_proxy                    = false
  $influxdb_proxy_suffix             = 'raw'
  $influxdb_proxy_flushInterval      = '10000'

  $librato_email                     = undef
  $librato_token                     = undef
  $librato_snapTime                  = '10000'
  $librato_countersAsGauges          = true
  $librato_skipInternalMetrics       = true
  $librato_retryDelaySecs            = '5'
  $librato_postTimeoutSecs           = '4'

  $stackdriver_apiKey                = undef
  $stackdriver_source                = undef
  $stackdriver_sourceFromPrefix      = false
  $stackdriver_sourcePrefixSeparator = '--'
  $stackdriver_sendTimerPercentiles  = false
  $stackdriver_debug                 = false

  $config                            = { }

  $dependencies                      = undef

  case $::osfamily {
    'RedHat', 'Amazon': {
      $init_location = '/etc/init.d/statsd'
      $init_mode     = '0755'
      $init_provider = 'redhat'
      $init_script   = 'puppet:///modules/statsd/statsd-init-rhel'
    }
    'Debian': {
      $init_location = '/etc/init/statsd.conf'
      $init_mode     = '0644'
      $init_provider = 'upstart'
      $init_script   = 'puppet:///modules/statsd/statsd-upstart'
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
