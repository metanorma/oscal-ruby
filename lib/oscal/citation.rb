require_relative "base_class"

module Oscal
  class Citation < Oscal::BaseClass
    KEY = %i(text props links)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
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
