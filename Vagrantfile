# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = 'puppet-statsd'
  config.vm.synced_folder "modules", "/tmp/puppet-modules", type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder ".", "/tmp/puppet-modules/statsd", type: "rsync", rsync__exclude: ".git/"

  config.vm.define "centos" do |centos|
    centos.vm.box     = 'puppetlabs/centos-7.0-64-puppet'
    centos.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests/vagrant"
      puppet.manifest_file  = "centos.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "ubuntu", primary: true do |ubuntu|
    ubuntu.vm.box     = 'puppetlabs/ubuntu-14.04-64-puppet'
    ubuntu.vm.provision :shell, :inline => "echo 'Updating apt...' && apt-get update -qq"
    ubuntu.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests/vagrant"
      puppet.manifest_file  = "ubuntu.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end
end
