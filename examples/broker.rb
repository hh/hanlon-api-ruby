$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'hanlon/api'

SERVER='http://10.0.9.1:8026/hanlon/api/v1'

Hanlon::Api.configure do |config|
  config.api_url = "#{SERVER}"
end

uuids = Hanlon::Api::Broker.list
puts uuids.join(',')

#print 'UUID to load? '
#uuid = gets.chomp
#broker = Hanlon::Api::Broker.find(uuid)
#puts "#{broker.chef_server_url}"

pbroker = Hanlon::Api::Broker.create({
              :name => 'chef_broker',
              :plugin => 'chef',
              :description => 'Chef Broker',
           }, {
              :user_description => 'Install Chef',
              :chef_server_url => 'http =>//10.0.9.2 =>8889',
              :chef_version => '11.14.2',
              :validation_key => '',
              :validation_client_name => 'chef-validator',
              :bootstrap_environment => '_default',
              :install_sh_url => 'http =>//opscode.com/chef/install.sh',
              :chef_client_path => 'chef-client',
              :base_run_list => ''
          })

puts pbroker.inspect