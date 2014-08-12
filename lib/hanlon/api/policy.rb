module Hanlon
module Api
  #hanlon policy add -p linux_deploy -l precise -m 5fLIR5p71rkiW8GjCN6ScJ -b none -t vmware_vm -e true
  class Policy < Resource
    attr_accessor :uuid,
                  :is_template,
                  :noun,
                  :tags,
                  :hidden,
                  :maximum_count,
                  :enabled,
                  :template,
                  :description,
                  :node_uuid,
                  :bind_timestamp,
                  :bound,
                  :label

    def self.client
      Api.api_client
    end

    def self.resource_path
      'policy'
    end

    def self.metadata
      { }
    end

  end

end
end

