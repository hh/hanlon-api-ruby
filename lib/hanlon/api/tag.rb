module Hanlon
module Api
  class Tag < Resource
    attr_accessor :uuid,
                  :version,
                  :classname,
                  :is_template,
                  :noun,
                  :name,
                  :hidden,
                  :template,
                  :description,
                  :hostname_prefix,
                  :osversion,
                  :label,
                  :domainname,
                  :root_password,
                  :counter

    def to_s
        "#{@name} - #{@label}"
    end

    def self.client
      Api.api_client
    end 

    def self.resource_path
      'model'
    end

    def self.metadata
      {
        hostname_prefix: {
          default: "node",
          example: "node",
          validation: "^[a-zA-Z0-9][a-zA-Z0-9\\-]*$",
          required: true,
          description: "node hostname prefix (will append node number)"
        },
        domainname: {
          default: "localdomain",
          example: "example.com",
          validation: "^[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9](\\.[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])*$",
          required: true,
          description: "local domain name (will be used in /etc/hosts file)"
        },
        root_password: {
          default: "test1234",
          example: "P@ssword!",
          validation: "^[\\S]{8,}",
          required: true,
          description: "root password (> 8 characters)"
        }
      }
    end

  end

end
end
