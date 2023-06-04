require_relative "base_class"

module Oscal
  class Merge < Oscal::BaseClass
    KEY = %i(combine flat as_is custom)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "custom"
        Custom.wrap(val)
      else
        val
      end
    end
  end
end
