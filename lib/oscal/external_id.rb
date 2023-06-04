require_relative "base_class"

module Oscal
  class ExternalId < Oscal::BaseClass
    KEY = %i(schema id)

    attr_accessor *KEY

    attr_serializable *KEY
  end
end
