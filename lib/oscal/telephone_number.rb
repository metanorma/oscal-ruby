require_relative "base_class"

module Oscal
  class TelephoneNumber < Oscal::BaseClass
    KEY = %i(type number)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
