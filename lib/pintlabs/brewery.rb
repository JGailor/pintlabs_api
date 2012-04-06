module Pintlabs
  class Brewery < Pintlabs::API
    attr_accessor :images

    def self.breweries(options = {})
      get("/breweries", options)["data"].map {|data| Brewery.new(data)}
    end

    def self.brewery(id, options = {})
      Brewery.new(get("/brewery/#{id}", options)["data"])
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

    def images=(attrs)
      @images = Images.new(attrs)
    end
  end
end