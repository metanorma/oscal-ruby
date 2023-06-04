require_relative "base_class"

module Oscal
  class Link < Oscal::BaseClass
    KEY = %i(href rel media_type text)

    attr_accessor *KEY

    attr_serializable *KEY
  end
end
