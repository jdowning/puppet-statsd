# puppet-statsd

[![Build Status](https://travis-ci.org/justindowning/puppet-statsd.png)](https://travis-ci.org/justindowning/puppet-statsd) [![Puppet Forge](http://img.shields.io/puppetforge/v/jdowning/statsd.svg?style=flat)](https://forge.puppetlabs.com/jdowning/statsd)

## Description

This Puppet module will install [statsd](https://github.com/etsy/statsd/) on Debian or RedHat.

## Installation

`puppet module install --modulepath /path/to/puppet/modules jdowning-statsd`

## Requirements

This module assumes nodejs & npm is installed on the host, but will not do it for you. I recommend using [puppet/nodejs](https://github.com/puppet-community/puppet-nodejs) to set this up.

## Usage
```puppet
    class { 'statsd':
      backends         => [ './backends/graphite'],
      graphiteHost     => 'my.graphite.host',
      flushInterval    => 1000,
      percentThreshold => [75, 90, 99],
    }
```

## Backends

You can install multiple backends. Supported backends include:  
* graphite  
* influxdb  
* librato  
* stackdriver  
* repeater

More information about the installation of each backend available in [manifests/backends.pp](https://github.com/justindowning/puppet-statsd/blob/master/manifests/backends.pp).

### Graphite

```
class { 'statsd':
  backends     => ['./backends/graphite'],
  graphiteHost => 'localhost'
}
```

### InfluxDB

```
class { 'statsd':
  backends      => ['statsd-influxdb-backend'],
  influxdb_host => 'localhost'
}
```

### Librato

```
class { 'statsd':
  backends      => ['statsd-librato-backend'],
  librato_email => 'foo@bar.com',
  librato_token => 'secret_token'
}
```

### Stackdriver

```
class { 'statsd':
  backends           => ['stackdriver-statsd-backend'],
  stackdriver_apiKey => 'apiKey'
}
```

### Repeater

```
class { 'statsd':
  backends         => ['./backends/repeater'],
  repeater         => [{"host" => 'my.statsd.host', port => 8125}],
  repeaterProtocol => 'udp4'
}
```

## Testing

```
bundle install
bundle exec librarian-puppet install
vagrant up
```

## Custom Nodejs Environment

Use the `$sysconfig_append` parameter to add custom sysconfig_append variables or run scripts in the `/etc/default/statsd` file.  For example, you could enable Redhat's software collections and add a custom path like so:

```
class { 'statsd':
  backends     => ['./backends/graphite'],
  graphiteHost => 'localhost',
  sysconfig_append  => [
    'source /opt/rh/nodejs010/enable',
    'PATH=/opt/my/path:$PATH',
  ],
}
```
