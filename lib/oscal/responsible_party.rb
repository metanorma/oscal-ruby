require_relative "base_class"

module Oscal
  class ResponsibleParty < Oscal::BaseClass
    KEY = %i(role_id party_uuids props links remakrs)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
        case key_name
        when 'party_uuids'
          PartyUuid.wrap(val)
        when 'props'
          Property.wrap(val)
        when 'links'
          Link.wrap(val)
        else
          val
        end
    end
  end
end
