# == Class statsd
class statsd (
  $ensure           = $statsd::params::ensure,
  $port             = $statsd::params::port,
  $graphiteHost     = $statsd::params::graphiteHost,
  $graphiteport     = $statsd::params::graphitePort,

  $backends         = $statsd::params::backends,
  $debug            = $statsd::params::debug,
  $address          = $statsd::params::address,
  $mgmt_address     = $statsd::params::mgmt_address,
  $mgmt_port        = $statsd::params::mgmt_port,
  $title            = $statsd::params::title,
  $healthStatus     = $statsd::params::healthStatus,
  $dumpMessages     = $statsd::params::dumpMessages,
  $flushInterval    = $statsd::params::flushInterval,
  $percentThreshold = $statsd::params::percentThreshold,
  $flush_counts     = $statsd::params::flush_counts,

  $influxdb_host    = $statsd::params::influxdb_host,
  $config           = $statsd::params::config,

  $init_script      = $statsd::params::init_script,
) inherits statsd::params {

  class { 'statsd::config': }

  package { 'statsd':
    ensure   => $ensure,
    provider => 'npm',
  }

  service { 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => [ Package['statsd'], File['/var/log/statsd'] ],
  }
}
