require_relative "base_class"

module Oscal
  class Modify < Oscal::BaseClass
    KEY = %i(set_parameters alters)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'set_parameters'
        SetParameter.wrap(val)
      when 'alters'
        Alter.wrap(val)
      else
        val
      end
    end
  end
end
