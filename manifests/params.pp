# == Class: statsd::params
class statsd::params {
  $ensure                            = 'present'
  $node_module_dir                   = '/usr/lib/node_modules'
  $nodejs_bin                        = '/usr/bin/node'
  $sysconfig_append                       = []

  $port                              = '8125'
  $address                           = '0.0.0.0'
  $configfile                        = '/etc/statsd/localConfig.js'
  $logfile                           = '/var/log/statsd/statsd.log'

  $manage_service                    = true
  $service_ensure                    = 'running'
  $service_enable                    = true

  $manage_backends                   = true
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
  $prefix_stats                      = 'statsd'
  $keyNameSanitize                   = true

  $deleteIdleStats                   = undef
  $deleteGauges                      = undef
  $deleteTimers                      = undef
  $deleteSets                        = undef
  $deleteCounters                    = undef

  $graphiteHost                      = 'localhost'
  $graphitePort                      = '2003'
  $graphite_legacyNamespace          = true
  $graphite_globalPrefix             = 'stats'
  $graphite_prefixCounter            = 'counters'
  $graphite_prefixTimer              = 'timers'
  $graphite_prefixGauge              = 'gauges'
  $graphite_prefixSet                = 'sets'
  $graphite_globalSuffix             = undef

  $influxdb_package_name             = 'statsd-influxdb-backend'
  $influxdb_host                     = undef
  $influxdb_port                     = '8086'
  $influxdb_database                 = 'statsd'
  $influxdb_username                 = 'root'
  $influxdb_password                 = 'root'
  $influxdb_version                  = '0.8'
  $influxdb_flush                    = true
  $influxdb_proxy                    = false
  $influxdb_proxy_suffix             = 'raw'
  $influxdb_proxy_flushInterval      = '10000'
  $influxdb_include_statsd_metrics   = false
  $influxdb_include_influxdb_metrics = false

  $librato_email                     = undef
  $librato_token                     = undef
  $librato_source                    = undef
  $librato_snapTime                  = '10'
  $librato_countersAsGauges          = true
  $librato_skipInternalMetrics       = true
  $librato_retryDelaySecs            = '5'
  $librato_postTimeoutSecs           = '4'
  $librato_includeMetrics            = undef
  $librato_excludeMetrics            = undef
  $librato_globalPrefix              = undef
  $librato_alwaysSuffixPercentile    = false

  $stackdriver_apiKey                = undef
  $stackdriver_source                = undef
  $stackdriver_sourceFromPrefix      = false
  $stackdriver_sourcePrefixSeparator = '--'
  $stackdriver_sendTimerPercentiles  = false
  $stackdriver_debug                 = false

  $repeater                          = undef
  $repeaterProtocol                  = undef

  $config                            = { }

  $dependencies                      = undef

  $package_name                      = 'statsd'
  $package_source                    = undef
  $package_provider                  = 'npm'

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
