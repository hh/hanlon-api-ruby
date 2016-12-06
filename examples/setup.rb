require 'hanlon/api'

Hanlon::Api.configure do |config|
  SERVER="http://1.1.1.11:8026/hanlon/api/v1"
  config.api_url = "#{SERVER}"
end
p=Hanlon::Api::Broker::ChefMetal.create({name: 'sweetbroker', plugin:'chef_metal', description: 'Chef Metal Broker \m/', req_metadata_params: {}},{user_description: 'install chef', chef_server_url: 'http://127.0.0.1:8000',client_key: 'pem', node_name: 'web083', install_sh_url: 'http://fobar/install.sh'})
