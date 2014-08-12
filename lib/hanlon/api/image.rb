module Hanlon
module Api
  class Image < Resource
    attr_accessor :id,
                  :first_name,
                  :last_name,
                  :userid,
                  :groups

    def to_s
        "#{@first_name} #{@last_name} <#{@userid}> - [#{@groups.join(', ')}]"
    end

    def self.client
      Api.api_client
    end 

    def self.resource_path
      "users"
    end

    def update(userid)
        response = @client.put do |req|
            req.url  "#{@resource_path}/#{userid}"
            req.headers["Content-Type"] = "application/json"
            req.body = self.to_json
        end
        self.from_json(response.body)
    end

    def self.find(userid)
        response = client.get "#{resource_path}/#{userid}"
        new.from_json(response.body)
    end

    def self.create(userid, opts = {})
        response = client.post do |req|
            req.url "#{resource_path}/#{userid}"
            req.headers["Content-Type"] = "application/json"
            req.body = opts.to_json
        end
        new.from_json(response.body)
    end

  end

end
end
