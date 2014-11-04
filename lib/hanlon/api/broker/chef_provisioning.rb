require 'hanlon/api/broker'

module Hanlon
module Api
class Broker
    class ChefProvisioning < Broker

      attr_accessor :chef_server_url,
                    :chef_version,
                    :node_name,
                    :client_key,
                    :install_sh_url,
                    :chef_client_path

      def self.metadata
        {
          chef_server_url: {
              default: '',
              example: 'https://chef.example.com:4000',
              validation: "(?x-mi: ([a-zA-Z][\\-+.a-zA-Z\\d]*): (?# 1: scheme) (?: ((?:[\\-_.!~*'()a-zA-Z\\d;?:@&=+$,]|%[a-fA-F\\d]{2})(?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*) (?# 2: opaque) | (?:(?: \\/\\/(?: (?:(?:((?:[\\-_.!~*'()a-zA-Z\\d;:&=+$,]|%[a-fA-F\\d]{2})*)@)? (?# 3: userinfo) (?:((?:(?:[a-zA-Z0-9\\-.]|%\\h\\h)+|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}|\\[(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})|(?:(?:[a-fA-F\\d]{1,4}:)*[a-fA-F\\d]{1,4})?::(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}))?)\\]))(?::(\\d*))?))? (?# 4: host, 5: port) | ((?:[\\-_.!~*'()a-zA-Z\\d$,;:@&=+]|%[a-fA-F\\d]{2})+) (?# 6: registry) ) | (?!\\/\\/)) (?# XXX: '\\/\\/' is the mark for hostport) (\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*(?:\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*)*)? (?# 7: path) )(?:\\?((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 8: query) ) (?:\\#((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 9: fragment) )",
              required: true,
              description: 'the URL for the Chef server.'
          },
          chef_version: {
              default: '',
              example: '10.16.2',
              validation: "^[0-9]+\\.[0-9]+\\.[0-9]+(\\.[a-zA-Z0-9\\.]+)?$",
              required: true,
              description: 'the Chef version (used in gem install).'
          },
          node_name: {
              default: '',
              example: 'web00',
              validation: "^[\\w._-]+$",
              required: true,
              description: "The node's name"
          },
          client_key: {
              default: '',
              example: 'Foo',
              validation: '.*',
              required: true,
              description: "The client's PEM-encoded key"
          },
          install_sh_url: {
              default: 'http://opscode.com/chef/install.sh',
              example: 'http://mirror.example.com/install.sh',
              validation: "(?x-mi: ([a-zA-Z][\\-+.a-zA-Z\\d]*): (?# 1: scheme) (?: ((?:[\\-_.!~*'()a-zA-Z\\d;?:@&=+$,]|%[a-fA-F\\d]{2})(?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*) (?# 2: opaque) | (?:(?: \\/\\/(?: (?:(?:((?:[\\-_.!~*'()a-zA-Z\\d;:&=+$,]|%[a-fA-F\\d]{2})*)@)? (?# 3: userinfo) (?:((?:(?:[a-zA-Z0-9\\-.]|%\\h\\h)+|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}|\\[(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})|(?:(?:[a-fA-F\\d]{1,4}:)*[a-fA-F\\d]{1,4})?::(?:(?:[a-fA-F\\d]{1,4}:)*(?:[a-fA-F\\d]{1,4}|\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}))?)\\]))(?::(\\d*))?))? (?# 4: host, 5: port) | ((?:[\\-_.!~*'()a-zA-Z\\d$,;:@&=+]|%[a-fA-F\\d]{2})+) (?# 6: registry) ) | (?!\\/\\/)) (?# XXX: '\\/\\/' is the mark for hostport) (\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*(?:\\/(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*(?:;(?:[\\-_.!~*'()a-zA-Z\\d:@&=+$,]|%[a-fA-F\\d]{2})*)*)*)? (?# 7: path) )(?:\\?((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 8: query) ) (?:\\#((?:[\\-_.!~*'()a-zA-Z\\d;\\/?:@&=+$,\\[\\]]|%[a-fA-F\\d]{2})*))? (?# 9: fragment) )",
              required: true,
              description: 'the Omnibus installer script URL.'
          },
          chef_client_path: {
              default: 'chef-client',
              example: '/usr/local/bin/chef-client',
              validation: "^[\\w._-]+$",
              required: true,
              description: 'an alternate path to the chef-client binary.'
          }
        }
      end

    end
end
end
end
