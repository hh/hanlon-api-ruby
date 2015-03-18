require 'json'

module Hanlon
module Api

  class Resource

    def initialize
      @client = self.class.client
      @resource_path = self.class.resource_path
    end 

    def self.attr_accessor(*vars)
       @attributes ||= []
       @attributes.concat vars
       
       @writable ||= []
       @writable.concat vars
       super
    end

    def self.attr_reader(*vars)
      @attributes ||= []
      @attributes.concat vars

      @readonly ||= []
      @readonly.concat vars
      super
    end

    def self.load_multiple(json_data)
      results = []

      records = JSON.parse(json_data)
      records.each do |record_hash|
        results << new.from_hash(record_hash)
      end

      results
    end

    def to_json(*a)
      ignored = [:@client, :@resource_path]

      hash = {}
      (self.instance_variables - ignored).each do |var|
        varname = var.to_s.gsub("@", "")
        hash[varname] = self.instance_variable_get var
      end
      hash.to_json(*a)
    end

    def from_json string
      response = JSON.load string
      from_hash response['response']
    end

    def from_hash hash
      hash.each do |k,v|
        key = k.gsub(/^@/, '')
        begin
          self.instance_variable_set("@#{key}", v)
        rescue NameError => ne
          # nothing...
        end
      end
      self
    end

    def update
      response = @client.put do |req|
        req.url "#{@resource_path}/#{id}"
        req.headers['Content-Type'] = 'application/json'
        req.body = self.to_json
      end
      self.from_json(response.body)
    end

    def self.list
      response = client.get "#{resource_path}"
      results = JSON.parse(response.body)['response']

      entities = []

      results.each do |e|
        e.each do |k,v|
          entities << v if k == '@uuid'
        end
      end

      entities
    end

    def self.find(uuid)
      response = client.get "#{resource_path}/#{uuid}"
      new.from_json(response.body)
    end

    def self.filter(key, value)
      #/hanlon/api/v1/node?status=inactive
      response = client.get "#{resource_path}/?#{key}=#{value}"
    end

    def self.create(opts = {}, classparams = {})
      # This is ... gross.
      classparams.each { |k,v|
        opts["@#{k}"] = v
      }
      # Super gross...
      #opts[:req_metadata_hash] = self.metadata

      response = client.post do |req|
        req.url "#{resource_path}"
        req.headers['Content-Type'] = 'application/json'
        req.body = opts.to_json
      end
      new.from_json(response.body)
    end

    def self.destroy(uuid)
      response = client.delete do |req|
         req.url "#{resource_path}/#{uuid}"
         req.headers["Content-Type"] = "application/json"
      end
    end

  end

end
end