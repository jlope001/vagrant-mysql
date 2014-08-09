# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'

if ! ENV.has_key?("MYSQL_SETUP")
  puts 'required environment variables not setup, please source defaults'
  exit 1
end

Vagrant.configure("2") do |config|
  config.vm.define "mysql" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "./mysql"
      d.name = "mysql"
      d.env = {'MYSQL_ROOT_PASSWORD' => ENV['MYSQL_ROOT_PASSWORD']}
    end
  end
end
