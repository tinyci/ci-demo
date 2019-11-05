# -*- mode: ruby -*-
# vi: set ft=ruby :
#
#
# Customize the following variables
#
#
#
#erq
#
# End customization section
#

load './customize.rb'

def getip(i)
  "#{SUBNET}.#{i+2}"
end

Vagrant.configure("2") do |config|
  HOSTS.each_with_index do |host, i|
    role = host.keys[0]
    config.vm.define role do |node|
      # Every Vagrant development environment requires a box. You can search for
      # boxes at https://vagrantcloud.com/search.
      node.vm.box = "ubuntu/bionic64"

      node.vm.network "private_network", ip: getip(i)
      node.vm.hostname = role

      # config.vm.network "public_network"
      # config.vm.synced_folder "../data", "/vagrant_data"

      node.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = "1024"
      end

      if i == (HOSTS.length - 1)
        node.vm.provision "ansible" do |a|
          a.groups = { }
          a.host_vars = {}

          HOSTS.each do |h|
            h.each_with_index do |(k,v), x|
              a.host_vars[k] = { "runner_name" => "%s-%d" % [k, x] }
              v.each do |value|
                a.groups[value] ||= []
                a.groups[value].push(k)
              end
            end
          end

          a.extra_vars = {
            tinyci_host:         getip(0),
            oauth_client_id:     OAUTH_CLIENT_ID,
            oauth_client_secret: OAUTH_CLIENT_SECRET,
            fixed_capabilities: {
              "#{GITHUB_USERNAME}": %w[
                modify:user
                modify:ci
                submit
                cancel
              ]
            }
          }

          a.limit = "all"
          a.playbook = "ci-deploy/playbook.yml"
        end
      end
    end
  end
end
