require_relative "serializer"

module Oscal
  class Alter
    include Serializer

    KEY = %i(control_id class removes adds)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Alter
      return Alter.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Alter.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Alter")
        end

        val = case key_name
        when 'removes'
          Remove.wrap(val)
        when 'adds'
          Add.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
