require 'spec_helper'

describe 'statsd' do

  let(:facts) { { :osfamily => 'Debian' } }

  it { should contain_class("statsd::params") }
  it { should contain_statsd__backends }
  it { should contain_statsd__config }
  it { should contain_package('statsd').with_ensure('present') }
  it { should contain_service('statsd').with_ensure('running') }

end
