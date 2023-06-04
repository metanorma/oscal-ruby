require_relative "base_class"

module Oscal
  class Group < Oscal::BaseClass
    KEY = %i(id klass title params props links parts groups
             controls insert_controls)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "params"
        Parameter.wrap(val)
      when "props"
        Property.wrap(val)
      when "links"
        Link.wrap(val)
      when "parts"
        Part.wrap(val)
      when "groups"
        Group.wrap(val)
      when "controls"
        Control.wrap(val)
      when "insert_controls"
        InsertControl.wrap(val)
      else
        val
      end
    end
  end
end
