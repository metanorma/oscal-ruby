require_relative "base_class"

module Oscal
  class Location < Oscal::BaseClass
    KEY = %i(uuid title address email_addresses telephone_numbers urls
             props links remakrs)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "address"
        Address.wrap(val)
      when "email_addresses"
        EmailAddress.wrap(val)
      when "telephone_numbers"
        TelephoneNumber.wrap(val)
      when "urls"
        Url.wrap(val)
      when "props"
        Property.wrap(val)
      when "links"
        Link.wrap(val)
      else
        val
      end
    end
  end
end
