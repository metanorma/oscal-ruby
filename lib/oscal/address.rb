require_relative "serializer"

module Oscal
  class Address
    include Serializer

    KEY = %i(type addr_lines city state postal_code country)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Address
      return Address.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Address.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Address")
        end

        val = case key_name
        when 'addr_lines'
          AddressLine.wrap(val)
        when 'links'
          Link.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
