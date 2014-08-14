require 'hanlon/api/broker'

module Hanlon
module Api
class Broker
  class Chef < Broker

    attr_accessor :chef_server_url,
                  :chef_version,
                  :validation_key,
                  :validation_client_name,
                  :bootstrap_environment,
                  :install_sh_url,
                  :chef_client_path,
                  :base_run_list

    def self.metadata
      {
          chef_server_url: {
              default: '',
              example: 'https://chef.example.com:4000',
              validation: '.*', #"(?x-mi: ([a-zA-Z][\\-+.a-zA-Z\\d]*): (?# 1: scheme) (?: ((?:[\\-_.!~*'()a-zA-Z\\d;?:@&=+$,]|%[a-fA-F\\d]{2})(?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*) (?# 2: opaque) | (?:(?: \\/\\/(?: (?:(?:((?:[\\-_.!~*'()a-zA-Z\\d;:&=+$,]|%[a-fA-F\\d]{2})*)@)? (?# 3: userinfo) (?:((?:(?:[a-zA-Z0-9\\-.]|%\\h\\h)+|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}|\\[(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})|(?:(?:[a-fA-F\\d]{1,4}:)*[a-fA-F\\d]{1,4})?::(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}))?)\\]))(?::(\\d*))?))? (?# 4: host, 5: port) | ((?:[\\-_.!~*'()a-zA-Z\\d$,;:@&=+]|%[a-fA-F\\d]{2})+) (?# 6: registry) ) | (?!\\/\\/)) (?# XXX: '\\/\\/' is the mark for hostport) (\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*(?:\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*)*)? (?# 7: path) )(?:\\?((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 8: query) ) (?:\\#((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 9: fragment) )",
              required: true,
              description: 'the URL for the Chef server.'
          },
          chef_version: {
              default: '',
              example: '10.16.2',
              validation: ".*", #"^[0-9]+\\.[0-9]+\\.[0-9]+(\\.[a-zA-Z0-9\\.]+)?$",
              required: true,
              description: 'the Chef version (used in gem install).'
          },
          validation_key: {
              default: '',
              example: "-----BEGIN RSA PRIVATE KEY-----\\nMIIEpAIBAA...",
              validation: '.*',
              required: true,
              description: 'a paste of the contents of the validation.pem file, followed by a blank line.',
              multiline: true
          },
          validation_client_name: {
              default: 'chef-validator',
              example: 'myorg-validator',
              validation: ".*", #"^[\\w._-]+$",
              required: true,
              description: 'the validation client name.'
          },
          bootstrap_environment: {
              default: '_default',
              example: 'production',
              validation: ".*", #"^[\\w._-]+$",
              required: true,
              description: 'the Chef environment in which the chef-client will run.'
          },
          install_sh_url: {
              default: 'http://opscode.com/chef/install.sh',
              example: 'http://mirror.example.com/install.sh',
              validation: ".*", #"(?x-mi: ([a-zA-Z][\\-+.a-zA-Z\\d]*): (?# 1: scheme) (?: ((?:[\\-_.!~*'()a-zA-Z\\d;?:@&=+$,]|%[a-fA-F\\d]{2})(?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*) (?# 2: opaque) | (?:(?: \\/\\/(?: (?:(?:((?:[\\-_.!~*'()a-zA-Z\\d;:&=+$,]|%[a-fA-F\\d]{2})*)@)? (?# 3: userinfo) (?:((?:(?:[a-zA-Z0-9\\-.]|%\\h\\h)+|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}|\\[(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})|(?:(?:[a-fA-F\\d]{1,4}:)*[a-fA-F\\d]{1,4})?::(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}))?)\\]))(?::(\\d*))?))? (?# 4: host, 5: port) | ((?:[\\-_.!~*'()a-zA-Z\\d$,;:@&=+]|%[a-fA-F\\d]{2})+) (?# 6: registry) ) | (?!\\/\\/)) (?# XXX: '\\/\\/' is the mark for hostport) (\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*(?:\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*)*)? (?# 7: path) )(?:\\?((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 8: query) ) (?:\\#((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 9: fragment) )",
              required: true,
              description: 'the Omnibus installer script URL.'
          },
          chef_client_path: {
              default: 'chef-client',
              example: '/usr/local/bin/chef-client',
              validation: ".*", #^[\\w._-]+$",
              required: true,
              description: 'an alternate path to the chef-client binary.'
          },
          base_run_list: {
              default: '',
              example: 'role[base],role[another]',
              validation: ".*", #^(role|recipe)\\[[^\\]]+\\](\\s*,\\s*(role|recipe)\\[[^\\]]+\\])*$",
              required: false,
              description: 'an optional run_list of common base roles.'
          }
      }
    end

  end
end
end
end