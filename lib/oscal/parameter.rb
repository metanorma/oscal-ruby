require_relative "serializer"

module Oscal
  class Parameter
    include Serializer

    KEY = %i(id class depneds_on props links label usage
      constraints guidelines values select remarks)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Parameter
      return Parameter.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Parameter.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Parameter")
        end

        val = case key_name
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

        send("#{key_name}=", val)
      end
    end
  end
end
