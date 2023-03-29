require_relative "base_class"

module Oscal
  class ExcludeControl < Oscal::BaseClass
    KEY = %i(with_child_controls with_ids matching)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'with_ids'
        WithId.wrap(val)
      when 'matching'
        Matching.wrap(val)
      else
        val
      end
    end
  end
end
