# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.box_check_update = false

  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

  # config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "libvirt" do |libvirt|
    # Display the VirtualBox GUI when booting the machine
    #libvirt.gui = true
    #libvirt.cpu = 1
    libvirt.memory = "1024"
  end

  config.vm.define "prometheus1" do |prometheus1|
    prometheus1.vm.hostname = "prometheus-1"
  end

  config.vm.define "prometheus2" do |prometheus2|
    prometheus2.vm.hostname = "prometheus-1"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbooks/prometheus.yml"
    #ansible.inventory_path = "ansible/inventory/hosts.ini"
    ansible.groups = {
      "prometheus" => ["prometheus[1:2]"]
    }
  end
  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
