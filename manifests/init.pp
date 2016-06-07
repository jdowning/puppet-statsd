# == Class statsd
class statsd (
  $ensure                            = $statsd::params::ensure,
  $node_module_dir                   = $statsd::params::node_module_dir,
  $nodejs_bin                        = $statsd::params::nodejs_bin,
  $sysconfig_append                       = $statsd::params::sysconfig_append,

  $port                              = $statsd::params::port,
  $address                           = $statsd::params::address,
  $configfile                        = $statsd::params::configfile,
  $logfile                           = $statsd::params::logfile,

  $manage_service                    = $statsd::params::manage_service,
  $service_ensure                    = $statsd::params::service_ensure,
  $service_enable                    = $statsd::params::service_enable,

  $manage_backends                   = $statsd::params::manage_backends,
  $backends                          = $statsd::params::backends,
  $debug                             = $statsd::params::debug,
  $mgmt_address                      = $statsd::params::mgmt_address,
  $mgmt_port                         = $statsd::params::mgmt_port,
  $statsd_title                      = $statsd::params::statsd_title,
  $healthStatus                      = $statsd::params::healthStatus,
  $dumpMessages                      = $statsd::params::dumpMessages,
  $flushInterval                     = $statsd::params::flushInterval,
  $percentThreshold                  = $statsd::params::percentThreshold,
  $flush_counts                      = $statsd::params::flush_counts,
  $prefix_stats                      = $statsd::params::prefix_stats,
  $keyNameSanitize                   = $statsd::params::keyNameSanitize,

  $deleteIdleStats                   = $statsd::params::deleteIdleStats,
  $deleteGauges                      = $statsd::params::deleteGauges,
  $deleteTimers                      = $statsd::params::deleteTimers,
  $deleteSets                        = $statsd::params::deleteSets,
  $deleteCounters                    = $statsd::params::deleteCounters,

  $graphiteHost                      = $statsd::params::graphiteHost,
  $graphitePort                      = $statsd::params::graphitePort,
  $graphite_legacyNamespace          = $statsd::params::graphite_legacyNamespace,
  $graphite_globalPrefix             = $statsd::params::graphite_globalPrefix,
  $graphite_prefixCounter            = $statsd::params::graphite_prefixCounter,
  $graphite_prefixTimer              = $statsd::params::graphite_prefixTimer,
  $graphite_prefixGauge              = $statsd::params::graphite_prefixGauge,
  $graphite_prefixSet                = $statsd::params::graphite_prefixSet,
  $graphite_globalSuffix             = $statsd::params::graphite_globalSuffix,

  $influxdb_package_name             = $statsd::params::influxdb_package_name,
  $influxdb_host                     = $statsd::params::influxdb_host,
  $influxdb_port                     = $statsd::params::influxdb_port,
  $influxdb_database                 = $statsd::params::influxdb_database,
  $influxdb_username                 = $statsd::params::influxdb_username,
  $influxdb_password                 = $statsd::params::influxdb_password,
  $influxdb_version                  = $statsd::params::influxdb_version,
  $influxdb_flush                    = $statsd::params::influxdb_flush,
  $influxdb_proxy                    = $statsd::params::influxdb_proxy,
  $influxdb_proxy_suffix             = $statsd::params::influxdb_proxy_suffix,
  $influxdb_proxy_flushInterval      = $statsd::params::influxdb_proxy_flushInterval,
  $influxdb_include_statsd_metrics   = $statsd::params::influxdb_include_statsd_metrics,
  $influxdb_include_influxdb_metrics = $statsd::params::influxdb_include_influxdb_metrics,

  $librato_email                     = $statsd::params::librato_email,
  $librato_token                     = $statsd::params::librato_token,
  $librato_source                    = $statsd::params::librato_source,
  $librato_snapTime                  = $statsd::params::librato_snapTime,
  $librato_countersAsGauges          = $statsd::params::librato_countersAsGauges,
  $librato_skipInternalMetrics       = $statsd::params::librato_skipInternalMetrics,
  $librato_retryDelaySecs            = $statsd::params::librato_retryDelaySecs,
  $librato_postTimeoutSecs           = $statsd::params::librato_postTimeoutSecs,
  $librato_includeMetrics            = $statsd::params::librato_includeMetrics,
  $librato_excludeMetrics            = $statsd::params::librato_excludeMetrics,
  $librato_globalPrefix              = $statsd::params::librato_globalPrefix,
  $librato_alwaysSuffixPercentile    = $statsd::params::librato_alwaysSuffixPercentile,

  $stackdriver_apiKey                = $statsd::params::stackdriver_apiKey,
  $stackdriver_source                = $statsd::params::stackdriver_source,
  $stackdriver_sourceFromPrefix      = $statsd::params::stackdriver_sourceFromPrefix,
  $stackdriver_sourcePrefixSeparator = $statsd::params::stackdriver_sourcePrefixSeparator,
  $stackdriver_sendTimerPercentiles  = $statsd::params::stackdriver_sendTimerPercentiles,
  $stackdriver_debug                 = $statsd::params::stackdriver_debug,

  $repeater                          = $statsd::params::repeater,
  $repeaterProtocol                  = $statsd::params::repeaterProtocol,

  $config                            = $statsd::params::config,

  $init_location                     = $statsd::params::init_location,
  $init_mode                         = $statsd::params::init_mode,
  $init_provider                     = $statsd::params::init_provider,
  $init_script                       = $statsd::params::init_script,

  $package_name                      = $statsd::params::package_name,
  $package_source                    = $statsd::params::package_source,
  $package_provider                  = $statsd::params::package_provider,

  $dependencies                      = $statsd::params::dependencies,
) inherits statsd::params {

  if $dependencies {
    $dependencies -> Class['statsd']
  }

  if $manage_backends {
    class { 'statsd::backends': }
  }
  class { 'statsd::config': }

  package { 'statsd':
    ensure   => $ensure,
    name     => $package_name,
    provider => $package_provider,
    source   => $package_source
  }

  if $manage_service == true {
    service { 'statsd':
      ensure    => $service_ensure,
      enable    => $service_enable,
      hasstatus => true,
      provider  => $init_provider,
      subscribe => Class['statsd::config'],
      require   => [ Package['statsd'], File['/var/log/statsd'] ],
    }
  }
}
