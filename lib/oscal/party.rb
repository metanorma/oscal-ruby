require_relative "base_class"

module Oscal
  class Party < Oscal::BaseClass
    KEY = %i(uuid type name short_name external_ids props links
             email_addresses telephone_numbers addresses location_uuids
             member_of_organizations remakrs)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "external_ids"
        ExternalId.wrap(val)
      when "props"
        Property.wrap(val)
      when "links"
        Link.wrap(val)
      when "email_addresses"
        EmailAddress.wrap(val)
      when "telephone_numbers"
        TelephoneNumber.wrap(val)
      when "addresses"
        Address.wrap(val)
      when "location_uuids"
        LocationUuid.wrap(val)
      when "member_of_organizations"
        MemberOfOrganization.wrap(val)
      else
        val
      end
    end
  end
end
