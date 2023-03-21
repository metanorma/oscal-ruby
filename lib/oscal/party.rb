require_relative "serializer"

module Oscal
  class Party
    include Serializer

    KEY = %i(uuid type name short_name external_ids props links email_addresses telephone_numbers addresses location_uuids member_of_organizations remakrs)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Party
      return Party.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Party.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Party")
        end

        val = case key_name
        when 'external_ids'
          ExternalId.wrap(val)
        when 'props'
          Property.wrap(val)
        when 'links'
          Link.wrap(val)
        when 'email_addresses'
          EmailAddress.wrap(val)
        when 'telephone_numbers'
          TelephoneNumber.wrap(val)
        when 'addresses'
          Address.wrap(val)
        when 'location_uuids'
          LocationUuid.wrap(val)
        when 'member_of_organizations'
          MemberOfOrganization.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
