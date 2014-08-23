# == Class statsd
class statsd (
  $ensure                            = $statsd::params::ensure,
  $node_module_dir                   = $statsd::params::node_module_dir,

  $port                              = $statsd::params::port,
  $address                           = $statsd::params::address,

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

  $graphiteHost                      = $statsd::params::graphiteHost,
  $graphitePort                      = $statsd::params::graphitePort,
  $graphite_legacyNamespace          = $statsd::params::graphite_legacyNamespace,
  $graphite_globalPrefix             = $statsd::params::graphite_globalPrefix,
  $graphite_prefixCounter            = $statsd::params::graphite_prefixCounter,
  $graphite_prefixTimer              = $statsd::params::graphite_prefixTimer,
  $graphite_prefixGauge              = $statsd::params::graphite_prefixGauge,
  $graphite_prefixSet                = $statsd::params::graphite_prefixSet,
  $graphite_globalSuffix             = $statsd::params::graphite_globalSuffix,

  $influxdb_host                     = $statsd::params::influxdb_host,
  $influxdb_port                     = $statsd::params::influxdb_port,
  $influxdb_database                 = $statsd::params::influxdb_database,
  $influxdb_username                 = $statsd::params::influxdb_username,
  $influxdb_password                 = $statsd::params::influxdb_password,
  $influxdb_flush                    = $statsd::params::influxdb_flush,
  $influxdb_proxy                    = $statsd::params::influxdb_proxy,
  $influxdb_proxy_suffix             = $statsd::params::influxdb_proxy_suffix,
  $influxdb_proxy_flushInterval      = $statsd::params::influxdb_proxy_flushInterval,

  $librato_email                     = $statsd::params::librato_email,
  $librato_token                     = $statsd::params::librato_token,
  $librato_snapTime                  = $statsd::params::librato_snapTime,
  $librato_countersAsGauges          = $statsd::params::librato_countersAsGauges,
  $librato_skipInternalMetrics       = $statsd::params::librato_skipInternalMetrics,
  $librato_retryDelaySecs            = $statsd::params::librato_retryDelaySecs,
  $librato_postTimeoutSecs           = $statsd::params::librato_postTimeoutSecs,

  $stackdriver_apiKey                = $statsd::params::stackdriver_apiKey,
  $stackdriver_source                = $statsd::params::stackdriver_source,
  $stackdriver_sourceFromPrefix      = $statsd::params::stackdriver_sourceFromPrefix,
  $stackdriver_sourcePrefixSeparator = $statsd::params::stackdriver_sourcePrefixSeparator,
  $stackdriver_sendTimerPercentiles  = $statsd::params::stackdriver_sendTimerPercentiles,
  $stackdriver_debug                 = $statsd::params::stackdriver_debug,

  $config                            = $statsd::params::config,

  $init_location                     = $statsd::params::init_location,
  $init_mode                         = $statsd::params::init_mode,
  $init_provider                     = $statsd::params::init_provider,
  $init_script                       = $statsd::params::init_script,

  $dependencies                      = $statsd::params::dependencies,
) inherits statsd::params {

  if $dependencies {
    $dependencies -> Class['statsd']
  }

  class { 'statsd::backends': }
  class { 'statsd::config': }

  package { 'statsd':
    ensure   => $ensure,
    provider => 'npm',
  }

  service { 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    provider  => $statsd::params::init_provider,
    require   => [ Package['statsd'], File['/var/log/statsd'] ],
  }
}
