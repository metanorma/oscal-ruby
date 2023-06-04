require_relative "base_class"

module Oscal
  class Revision < Oscal::BaseClass
    KEY = %i(title published last_modified version oscal_version
             props links remarks)

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
