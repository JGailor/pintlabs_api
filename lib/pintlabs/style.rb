module Pintlabs
  class Style
    def initialize(attrs = {})
      attrs.each do |name, value|
        unless self.methods.include?(:"#{name}=")
          self.class.send(:define_method, name.to_sym) {self.instance_variable_get(:"@#{name}")}
          self.class.send(:define_method, :"#{name}=") {|v| self.instance_variable_set(:"@#{name}", v)}
        end

        self.send(:"#{name}=", value)
      end
    end
  end
end