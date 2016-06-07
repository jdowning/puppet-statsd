# == Class: statsd::config
class statsd::config (
  $configfile                        = $statsd::configfile,
  $port                              = $statsd::port,
  $address                           = $statsd::address,
  $backends                          = $statsd::backends,
  $debug                             = $statsd::debug,
  $mgmt_address                      = $statsd::mgmt_address,
  $mgmt_port                         = $statsd::mgmt_port,
  $statsd_title                      = $statsd::statsd_title,
  $healthStatus                      = $statsd::healthStatus,
  $dumpMessages                      = $statsd::dumpMessages,
  $flushInterval                     = $statsd::flushInterval,
  $percentThreshold                  = $statsd::percentThreshold,
  $flush_counts                      = $statsd::flush_counts,
  $prefix_stats                      = $statsd::prefix_stats,
  $keyNameSanitize                   = $statsd::keyNameSanitize,
  $deleteIdleStats                   = $statsd::deleteIdleStats,
  $deleteGauges                      = $statsd::deleteGauges,
  $deleteTimers                      = $statsd::deleteTimers,
  $deleteSets                        = $statsd::deleteSets,
  $deleteCounters                    = $statsd::deleteCounters,
  $graphiteHost                      = $statsd::graphiteHost,
  $graphitePort                      = $statsd::graphitePort,
  $graphite_legacyNamespace          = $statsd::graphite_legacyNamespace,
  $graphite_globalPrefix             = $statsd::graphite_globalPrefix,
  $graphite_prefixCounter            = $statsd::graphite_prefixCounter,
  $graphite_prefixTimer              = $statsd::graphite_prefixTimer,
  $graphite_prefixGauge              = $statsd::graphite_prefixGauge,
  $graphite_prefixSet                = $statsd::graphite_prefixSet,
  $graphite_globalSuffix             = $statsd::graphite_globalSuffix,
  $influxdb_package_name             = $statsd::influxdb_package_name,
  $influxdb_host                     = $statsd::influxdb_host,
  $influxdb_port                     = $statsd::influxdb_port,
  $influxdb_database                 = $statsd::influxdb_database,
  $influxdb_username                 = $statsd::influxdb_username,
  $influxdb_password                 = $statsd::influxdb_password,
  $influxdb_version                  = $statsd::influxdb_version,
  $influxdb_flush                    = $statsd::influxdb_flush,
  $influxdb_proxy                    = $statsd::influxdb_proxy,
  $influxdb_proxy_suffix             = $statsd::influxdb_proxy_suffix,
  $influxdb_proxy_flushInterval      = $statsd::influxdb_proxy_flushInterval,
  $influxdb_include_statsd_metrics   = $statsd::influxdb_include_statsd_metrics,
  $influxdb_include_influxdb_metrics = $statsd::influxdb_include_influxdb_metrics,
  $librato_email                     = $statsd::librato_email,
  $librato_token                     = $statsd::librato_token,
  $librato_source                    = $statsd::librato_source,
  $librato_snapTime                  = $statsd::librato_snapTime,
  $librato_countersAsGauges          = $statsd::librato_countersAsGauges,
  $librato_skipInternalMetrics       = $statsd::librato_skipInternalMetrics,
  $librato_retryDelaySecs            = $statsd::librato_retryDelaySecs,
  $librato_postTimeoutSecs           = $statsd::librato_postTimeoutSecs,
  $librato_includeMetrics            = $statsd::librato_includeMetrics,
  $librato_excludeMetrics            = $statsd::librato_excludeMetrics,
  $librato_globalPrefix              = $statsd::librato_globalPrefix,
  $librato_alwaysSuffixPercentile    = $statsd::librato_alwaysSuffixPercentile,
  $stackdriver_apiKey                = $statsd::stackdriver_apiKey,
  $stackdriver_source                = $statsd::stackdriver_source,
  $stackdriver_sourceFromPrefix      = $statsd::stackdriver_sourceFromPrefix,
  $stackdriver_sourcePrefixSeparator = $statsd::stackdriver_sourcePrefixSeparator,
  $stackdriver_sendTimerPercentiles  = $statsd::stackdriver_sendTimerPercentiles,
  $stackdriver_debug                 = $statsd::stackdriver_debug,
  $repeater                          = $statsd::repeater,
  $repeaterProtocol                  = $statsd::repeaterProtocol,
  $config                            = $statsd::config,

  $sysconfig_append = $statsd::sysconfig_append,
  $nodejs_bin  = $statsd::nodejs_bin,
  $statsjs     = "${statsd::node_module_dir}/statsd/stats.js",
  $logfile     = $statsd::logfile,
) {

  file { '/etc/statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }->
  file { $configfile:
    content => template('statsd/localConfig.js.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { $statsd::init_location:
    source => $statsd::init_script,
    mode   => $statsd::init_mode,
    owner  => 'root',
    group  => 'root',
  }

  file {  $statsd::init_sysconfig:
    content => template('statsd/statsd-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/var/log/statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'nobody',
    group  => 'root',
  }

  file { '/usr/local/sbin/statsd':
    source => 'puppet:///modules/statsd/statsd-wrapper',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}
