require_relative "base_class"

module Oscal
  class HashObject < Oscal::BaseClass
    KEY = %i(algorithm value)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
