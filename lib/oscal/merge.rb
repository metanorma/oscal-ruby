require_relative "serializer"

module Oscal
  class Merge
    include Serializer

    KEY = %i(combine flat as_is custom)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Merge
      return Merge.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Merge.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Merge")
        end

        val = case key_name
        when 'custom'
          Custom.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
