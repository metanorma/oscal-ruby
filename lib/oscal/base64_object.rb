require_relative "base_class"

module Oscal
  class Base64Object < Oscal::BaseClass
    KEY = %i(filename media_type value)

    attr_accessor *KEY

    attr_serializable *KEY
  end
end
