# puppet-statsd

[![Puppet Forge](http://img.shields.io/puppetforge/v/jdowning/statsd.svg)](https://forge.puppetlabs.com/jdowning/statsd) [![Build Status](https://travis-ci.org/justindowning/puppet-statsd.png)](https://travis-ci.org/justindowning/puppet-statsd)

## Description

This Puppet module will install [statsd](https://github.com/etsy/statsd/) on Debian or RedHat.

## Installation

`puppet module install --modulepath /path/to/puppet/modules jdowning-statsd`

## Usage
```puppet
    class { 'statsd':
      address          => '10.20.1.2',
      graphiteHost     => 'my.graphite.host',
      flushInterval    => 1000,
      percentThreshold => [75, 90, 99],
    }
```

## Testing

```
bundle install
bundle librarian-puppet install
vagrant up
```
