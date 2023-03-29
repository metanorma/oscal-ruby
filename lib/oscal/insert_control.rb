require_relative "base_class"

module Oscal
  class InsertControl < Oscal::BaseClass
    KEY = %i(order include_all include_controls exclude_controls)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'include_controls'
        IncludeControl.wrap(val)
      when 'exclude_controls'
        ExcludeControls.wrap(val)
      else
        val
      end
    end
  end
end
