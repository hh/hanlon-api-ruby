require 'hanlon/api'

SERVER="http://1.1.1.11:8026/hanlon/api/v1"

Hanlon::Api.configure do |config|
  config.api_url = "#{SERVER}"
end

#puts Hanlon::Api::ActiveModel.list
pol1=Hanlon::Api::Policy.find(Hanlon::Api::Policy.list.first)
am1=Hanlon::Api::ActiveModel.filter('root_policy',pol1.uuid)
#am1=Hanlon::Api::ActiveModel.find(Hanlon::Api::ActiveModel.list.first)


