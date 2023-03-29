require_relative "base_class"

module Oscal
  class Add < Oscal::BaseClass
    KEY = %i(position by_id title params props links parts)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'params'
        Parameter.wrap(val)
      when 'props'
        Property.wrap(val)
      when 'links'
        Link.wrap(val)
      when 'part'
        Part.wrap(val)
      else
        val
      end
    end
  end
end
