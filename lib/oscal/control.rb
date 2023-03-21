module Oscal
  class Control
    KEY = %i(id title params props parts).freeze
    attr_accessor *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Control
      return Control.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Control.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Control")
        end

        val = cast_value_by_key(key_name, val)
        send("#{key_name}=", val)
      end
    end

    def cast_value_by_key(key_name, val)
      case key_name
      when "params"
        Parameter.wrap(val)
      when "props"
        Property.wrap(val)
      when "parts"
        Part.wrap(val)
      else
        val
      end
    end
  end
end
