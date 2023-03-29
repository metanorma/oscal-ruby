require_relative "base_class"

module Oscal
  class Constraint < Oscal::BaseClass
    KEY = %i(description tests)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'test'
        Test.wrap(val)
      else
        val
      end
    end
  end
end
