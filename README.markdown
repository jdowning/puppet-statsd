# puppet-statsd

[![Build Status](https://travis-ci.org/justindowning/puppet-influxdb.png)](https://travis-ci.org/justindowning/puppet-influxdb)

## Description

This Puppet module will install [statsd](https://github.com/etsy/statsd/) on Debian or RedHat.

## Installation

`puppet module install --modulepath /path/to/puppet/modules jdowning-statsd`

## Usage
```puppet
    class { 'statsd':
      graphite_host    => 'my.graphite.host',
      influxdb_host    => 'my.influxdb.host',
      flushinterval    => 1000, # flush every second
      percentthreshold => [75, 90, 99],
      address          => '10.20.1.2',
      listenport       => 2158,
      provider         => npm,
    }
```

## Testing

```
bundle install
bundle librarian-puppet install
vagrant up
```
