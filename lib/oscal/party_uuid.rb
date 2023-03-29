require_relative "base_class"

module Oscal
  class PartyUuid < Oscal::BaseClass
    KEY = %i(val)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
