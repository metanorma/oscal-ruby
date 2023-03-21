module Oscal
  class Parameter
    KEY = %i(id label select).freeze
    attr_accessor *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Parameter
      return Parameter.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Parameter.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Parameter")
        end

        send("#{key_name}=", val)
      end
    end
  end
end
