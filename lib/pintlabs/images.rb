module Pintlabs
  class Images
    attr_accessor :medium, :large, :icon

    def initialize(data = {})
      self.medium = data["medium"]
      self.large = data["large"]
      self.icon = data["icon"]
    end
  end
end