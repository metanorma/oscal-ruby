require_relative "serializer"

module Oscal
  class Constraint
    include Serializer

    KEY = %i(description tests)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Constraint
      return Constraint.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Constraint.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Constraint")
        end

        val = case key_name
        when 'test'
          Test.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
