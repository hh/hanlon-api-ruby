$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'hanlon/api'

SERVER="http://1.1.1.11:8026/hanlon/api/v1"

Hanlon::Api.configure do |config|
  config.api_url = "#{SERVER}"
end

uuids = Hanlon::Api::Broker.list
puts uuids.join(',')

#print 'UUID to load? '
#uuid = gets.chomp
#broker = Hanlon::Api::Broker.find(uuid)
#puts "#{broker.chef_server_url}"

pbroker = Hanlon::Api::Broker::ChefMetal.create(
         {
             :name => 'my sweet broker2',
             :plugin => 'chef_metal',
             :description => 'Chef Metal Broker \m/',
         }, {
             :user_description => 'Install Chef',
             :chef_server_url => 'http://foo.narf',
             :chef_version => "1.2.3.4",
             :client_key => 'pem',
             :node_name => 'web000',
             :install_sh_url => 'http://foo.narf/install.sh',
             :chef_client_path => 'chef-client',
         })

puts pbroker.inspect
