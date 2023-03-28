require_relative "serializer"

module Oscal
  class Add
    include Serializer

    KEY = %i(position by_id title params props links parts)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Add
      return Add.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Add.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Add")
        end

        val = case key_name
        when 'params'
          Parameter.wrap(val)
        when 'props'
          Property.wrap(val)
        when 'links'
          Link.wrap(val)
        when 'part'
          Part.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
