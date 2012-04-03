module Pintlabs
  class Availability
    attr_accessor :description, :name

    def initialize(data = {})
      self.description = data["description"]
      self.name = data["name"]
    end
  end
end