require_relative "base_class"

module Oscal
  class Select < Oscal::BaseClass
    KEY = %i(how_many choice)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "choice"
        Choice.wrap(val)
      else
        val
      end
    end
  end
end
