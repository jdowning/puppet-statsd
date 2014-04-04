# == Class statsd
class statsd (
  $ensure           = $statsd::params::ensure,
  $config           = $statsd::params::config,
  $graphite_host    = $statsd::params::graphite_host,
  $graphite_port    = $statsd::params::graphite_port,
  $influxdb_host    = $statsd::params::influxdb_host,
  $backends         = $statsd::params::backends,
  $address          = $statsd::params::address,
  $listenport       = $statsd::params::listenport,
  $flushinterval    = $statsd::params::flushinterval,
  $percentthreshold = $statsd::params::percentthreshold,
  $statsjs          = $statsd::params::statsjs,
  $init_script      = $statsd::params::init_script,
  $node_manage      = $statsd::params::node_manage,
  $node_version     = $statsd::params::node_version,
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
