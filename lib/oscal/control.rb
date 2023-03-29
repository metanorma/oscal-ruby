require_relative "base_class"

module Oscal
  class Control < Oscal::BaseClass
    KEY = %i(id klass title params props links parts controls)

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
      when 'parts'
        Part.wrap(val)
      when 'controls'
        Control.wrap(val)
      else
        val
      end
    end
  end
end
