require_relative "base_class"

module Oscal
  class Property < Oscal::BaseClass
    KEY = %i(name uuid ns value klass remarks)

    attr_accessor *KEY

    attr_serializable *KEY
  end
end
