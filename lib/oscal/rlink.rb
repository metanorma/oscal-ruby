require_relative "base_class"

module Oscal
  class Rlink < Oscal::BaseClass
    KEY = %i(href media_type hashes)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'hashes'
        HashObject.wrap(val)
      else
        val
      end
    end
  end
end
