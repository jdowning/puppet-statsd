class { 'nodejs': manage_repo => true }->
# http://blog.npmjs.org/post/78085451721/npms-self-signed-certificate-is-no-more
exec { '/usr/bin/npm config set ca=""': }->
class { 'statsd':
  backends           => [ './backends/graphite', 'statsd-influxdb-backend', 'statsd-librato-backend', 'stackdriver-statsd-backend'],
  influxdb_host      => 'localhost',
  librato_email      => 'foo@bar.com',
  librato_token      => 'secret_token',
  stackdriver_apiKey => 'foobar'
}
