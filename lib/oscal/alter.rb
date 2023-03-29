require_relative "base_class"

module Oscal
  class Alter < Oscal::BaseClass
    KEY = %i(control_id klass removes adds)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'removes'
        Remove.wrap(val)
      when 'adds'
        Add.wrap(val)
      else
        val
      end
    end
  end
end
