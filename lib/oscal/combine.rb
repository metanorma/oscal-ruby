require_relative "base_class"

module Oscal
  class Combine < Oscal::BaseClass
    KEY = %i(method)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
