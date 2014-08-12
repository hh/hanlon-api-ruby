$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'hanlon/api'

SERVER='http://10.0.9.1:8026/hanlon/api/v1'

Hanlon::Api.configure do |config|
  config.api_url = "#{SERVER}"
end

puts "Policies:"
uuids = Hanlon::Api::Policy.list
puts uuids.join(', ')

print 'Policy to load? '
uuid = gets.chomp
policy = Hanlon::Api::Policy.find(uuid)
puts "#{policy.inspect}"

puts "Models:"
uuids = Hanlon::Api::Model.list
puts uuids.join(', ')

print 'Model to use? '
model_uuid = gets.chomp

puts "Brokers:"
uuids = Hanlon::Api::Broker.list
puts uuids.join(', ')

print 'Broker to use? '
broker_uuid = gets.chomp


new_policy = Hanlon::Api::Policy.create({
                  label: "Test Policy",
                  model_uuid: model_uuid,
                  broker_uuid: broker_uuid,
                  template: "linux_deploy",
                  tags: "two_disks,memsize_1GiB,nics_2"
           })

puts new_policy.inspect