require_relative "base_class"

module Oscal
  class Address < Oscal::BaseClass
    KEY = %i(type addr_lines city state postal_code country)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'addr_lines'
        AddressLine.wrap(val)
      when 'links'
        Link.wrap(val)
      else
        val
      end
    end
  end
end
