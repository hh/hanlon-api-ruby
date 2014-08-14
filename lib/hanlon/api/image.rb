module Hanlon
module Api
  class Image < Resource
    attr_accessor :uuid,
                  :is_template,
                  :path_prefix,
                  :description,
                  :hidden,
                  :filename,
                  :verification_hash,
                  :os_name,
                  :os_version

    def to_s
        "#{uuid} #{os_name} #{os_version}"
    end

    def self.client
      Api.api_client
    end 

    def self.resource_path
      'image'
    end



  end

end
end
