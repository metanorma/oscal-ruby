require_relative "serializer"

module Oscal
  class Modify
    include Serializer

    KEY = %i(set_parameters alters)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Modify
      return Modify.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Modify.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Modify")
        end

        val = case key_name
        when 'set_parameters'
          SetParameter.wrap(val)
        when 'alters'
          Alter.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
