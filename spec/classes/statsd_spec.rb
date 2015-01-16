require 'spec_helper'

describe 'statsd', :type => :class do

  ['Debian', 'RedHat'].each do |osfamily|
    context "using #{osfamily}" do
      let(:facts) { {
        :osfamily => osfamily
      } }

      it { should contain_class('statsd') }
      it { should contain_class('statsd::params') }
      it { should contain_statsd__backends }
      it { should contain_statsd__config }
      it { should contain_package('statsd').with_ensure('present') }
      it { should contain_service('statsd').with_ensure('running') }
      it { should contain_service('statsd').with_enable(true) }

      it { should contain_file('/etc/statsd') }
      it { should contain_file('/etc/statsd/localConfig.js') }
      it { should contain_file('/etc/default/statsd') }
      it { should contain_file('/var/log/statsd') }
      it { should contain_file('/usr/local/sbin/statsd') }

      if osfamily == 'Debian'
        it { should contain_file('/etc/init/statsd.conf') }
      end

      if osfamily == 'RedHat'
        it { should contain_file('/etc/init.d/statsd') }
      end

      describe 'stopping the statsd service' do
	let(:params) {{
	  :service_ensure => 'stopped',
        }}
        it { should contain_service('statsd').with_ensure('stopped') }
      end

      describe 'disabling the statsd service' do
	let(:params) {{
	  :service_enable => false,
        }}
        it { should contain_service('statsd').with_enable(false) }
      end

      describe 'disabling the management of the statsd service' do
	let(:params) {{
	  :manage_service => false,
        }}
        it { should_not contain_service('statsd') }
      end
    end
  end

end
