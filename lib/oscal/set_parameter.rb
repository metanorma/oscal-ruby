require_relative "base_class"

module Oscal
  class SetParameter < Oscal::BaseClass
    KEY = %i(param_id klass depneds_on props links label usage
      constraints guidelines values select)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'props'
        Property.wrap(val)
      when 'links'
        Link.wrap(val)
      when 'constraints'
        Constraint.wrap(val)
      when 'guidelines'
        Guideline.wrap(val)
      when 'values'
        Value.wrap(val)
      when 'select'
        Select.wrap(val)
      else
        val
      end
    end
  end
end
