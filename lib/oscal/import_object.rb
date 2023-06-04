require_relative "base_class"

module Oscal
  class ImportObject < Oscal::BaseClass
    KEY = %i(href include_all include_controls exclude_controls)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "include_controls"
        IncludeControl.wrap(val)
      when "exclude_controls"
        ExcludeControl.wrap(val)
      else
        val
      end
    end
  end
end
