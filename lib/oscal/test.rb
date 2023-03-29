require_relative "base_class"

module Oscal
  class Test < Oscal::BaseClass
    KEY = %i(expression remarks)

    attr_accessor *KEY
    attr_serializable *KEY
  end
end
