require_relative "base_class"

module Oscal
  class DocumentId < Oscal::BaseClass
    KEY = %i(schema identifier)

    attr_accessor *KEY

    attr_serializable *KEY
  end
end
