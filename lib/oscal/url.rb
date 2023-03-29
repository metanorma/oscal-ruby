require_relative "base_class"

module Oscal
  class Url < Oscal::BaseClass
    KEY = %i(val)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
