require_relative "base_class"

module Oscal
  class Matching < Oscal::BaseClass
    KEY = %i(pattern)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
