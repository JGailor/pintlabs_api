module Pintlabs
  class API
    def self.index(resource, options = {})
      options.merge!({"key" => Pintlabs.config.api_key})
      HTTParty.get(Pintlabs.config.base_uri + resource, :query => options).tap do |response|
        if response["status"] != "success"
          raise Pintlabs::UnsuccessfulRequestError.new(response)
        end
      end
    end
  end
end