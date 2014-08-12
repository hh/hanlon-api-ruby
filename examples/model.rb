$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'hanlon/api'

SERVER="http://10.0.9.1:8026/hanlon/api/v1"

Hanlon::Api.configure do |config|
  config.api_url = "#{SERVER}"
end

uuids = Hanlon::Api::Model.list
puts uuids.join(',')

print "UUID to load? "
uuid = gets.chomp
model = Hanlon::Api::Model.find(uuid)
puts "#{model}"

model = Hanlon::Api::Model.create({
          label: "Test Model",
          image_uuid: "438CHtqAlKJoVHvNEVSArf",
          template: "ubuntu_precise",
        }, {
          hostname_prefix: "test",
          domainname: "testdomain.com",
          root_password: "test4321"
        })

puts model.inspect