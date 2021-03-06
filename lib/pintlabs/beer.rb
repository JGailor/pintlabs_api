module Pintlabs
  class Beer < Pintlabs::API
    attr_accessor :labels, :style, :available, :glass

    def self.beers(options = {})
      get("/beers", options)["data"].map {|data| Beer.new(data)}
    end

    def self.beer(id, options = {})
      Beer.new(get("/beer/#{id}", options)["data"])
    end

    def initialize(attrs = {})
      attrs.each do |name, value|
        unless self.methods.include?(:"#{name}=")
          self.class.send(:define_method, name.to_sym) {self.instance_variable_get(:"@#{name}")}
          self.class.send(:define_method, :"#{name}=") {|v| self.instance_variable_set(:"@#{name}", v)}
        end

        self.send(:"#{name}=", value)
      end
    end

    def labels=(attrs)
      @labels = Labels.new(attrs)
    end

    def style=(attrs)
      @style = Style.new(attrs)
    end

    def available=(attrs)
      @available = Availability.new(attrs)
    end

    def glass=(attrs)
      @glass = Glass.new(attrs)
    end 
  end
end