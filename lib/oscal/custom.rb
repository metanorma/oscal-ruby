require_relative "base_class"

module Oscal
  class Custom < Oscal::BaseClass
    KEY = %i(groups insert_controls)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "groups"
        Group.wrap(val)
      when "insert_controls"
        InsertControl.wrap(val)
      else
        val
      end
    end
  end
end
