require_relative "serializer"

module Oscal
  class Location
    include Serializer

    KEY = %i(uuid title address email_addresses telephone_numbers urls props links remakrs)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Location
      return Location.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Location.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Location")
        end

        val = case key_name
        when 'address'
          Address.wrap(val)
        when 'email_addresses'
          EmailAddress.wrap(val)
        when 'telephone_numbers'
          TelephoneNumber.wrap(val)
        when 'urls'
          Url.wrap(val)
        when 'props'
          Property.wrap(val)
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
