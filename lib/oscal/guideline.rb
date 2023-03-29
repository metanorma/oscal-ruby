require_relative "base_class"

module Oscal
  class Guideline < Oscal::BaseClass
    KEY = %i(prose)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
