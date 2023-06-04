require_relative "base_class"

module Oscal
  class Role < Oscal::BaseClass
    KEY = %i(id title short_name description props links remakrs)

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
