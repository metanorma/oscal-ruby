require_relative "base_class"

module Oscal
  class BackMatter < Oscal::BaseClass
    KEY = %i(resources)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'resources'
        Resource.wrap(val)
      else
        val
      end
    end
  end
end
