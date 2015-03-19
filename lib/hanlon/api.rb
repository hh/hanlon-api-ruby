require "hanlon/api/version"
require 'faraday'
require 'json'
# /hanlon/api/v1/

module Hanlon
  module Api
    autoload :Resource,          'hanlon/api/resource'
    autoload :Broker,            'hanlon/api/broker'
    autoload :ChefMetalBroker,   'hanlon/api/broker/chef_metal'
    autoload :Image,             'hanlon/api/image'
    autoload :Model,             'hanlon/api/model'
    autoload :ActiveModel,       'hanlon/api/active_model'
    autoload :Policy,            'hanlon/api/policy'
    require 'hanlon/api/broker/chef_metal'

    class << self
      attr_accessor :configuration
    end

    def self.api_client
      Api.client(Api.configuration.api_url)
    end

    def self.client(api_url)
      Faraday.new(:url => api_url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      attr_accessor :api_url

      def initialize
        @api_url = 'http://localhost:8080'
      end

    end
  end
end
