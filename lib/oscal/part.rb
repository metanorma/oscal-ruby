require_relative "base_class"

module Oscal
  class Part < Oscal::BaseClass
    KEY = %i(id name ns klass title props prose parts links)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "props"
        Property.wrap(val)
      when "parts"
        Part.wrap(val)
      when "links"
        Link.wrap(val)
      else
        val
      end
    end
  end
end
