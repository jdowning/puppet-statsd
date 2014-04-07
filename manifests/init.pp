# == Class statsd
class statsd (
  $ensure            = $statsd::params::ensure,
  $port              = $statsd::params::port,
  $graphiteHost      = $statsd::params::graphiteHost,
  $graphiteport      = $statsd::params::graphitePort,

  $backends          = $statsd::params::backends,
  $debug             = $statsd::params::debug,
  $address           = $statsd::params::address,
  $mgmt_address      = $statsd::params::mgmt_address,
  $mgmt_port         = $statsd::params::mgmt_port,
  $statsd_title      = $statsd::params::statsd_title,
  $healthStatus      = $statsd::params::healthStatus,
  $dumpMessages      = $statsd::params::dumpMessages,
  $flushInterval     = $statsd::params::flushInterval,
  $percentThreshold  = $statsd::params::percentThreshold,
  $flush_counts      = $statsd::params::flush_counts,

  $influxdb_host     = $statsd::params::influxdb_host,
  $influxdb_port     = $statsd::params::influxdb_port,
  $influxdb_database = $statsd::params::influxdb_database,
  $influxdb_username = $statsd::params::influxdb_username,
  $influxdb_password = $statsd::params::influxdb_password,

  $config            = $statsd::params::config,

  $node_module_dir   = $statsd::params::node_module_dir,
  $init_script       = $statsd::params::init_script,
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
