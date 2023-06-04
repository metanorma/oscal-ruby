require_relative "base_class"

module Oscal
  class Remove < Oscal::BaseClass
    KEY = %i(by_name by_class by_id by_item_name by_ns)

    attr_accessor *KEY

    attr_serializable *KEY
  end
end
