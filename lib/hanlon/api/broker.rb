module Hanlon
module Api

  class Broker < Resource
    attr_accessor :uuid,
                  :plugin,
                  :is_template,
                  :noun,
                  :hidden,
                  :description,
                  :version,
                  :name

    def self.client
      Api.api_client
    end

    def self.resource_path
      'broker'
    end

    def self.metadata
      raise 'Not implemented in subclass!'
    end

  end

end
end

