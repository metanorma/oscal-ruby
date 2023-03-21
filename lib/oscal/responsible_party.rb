require_relative "serializer"

module Oscal
  class ResponsibleParty
    include Serializer

    KEY = %i(role_id party_uuids props links remakrs)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? ResponsibleParty
      return ResponsibleParty.new(obj) unless obj.is_a? Array

      obj.map do |x|
        ResponsibleParty.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in ResponsibleParty")
        end

        val = case key_name
        when 'party_uuids'
          PartyUuid.wrap(val)
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
