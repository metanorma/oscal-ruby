require_relative "base_class"

module Oscal
  class Value < Oscal::BaseClass
    include Serializer

    KEY = %i(val)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Value
      return Value.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Value.wrap(x)
      end
    end

    def initialize(options={})
      unless options.is_a? Hash
        options = {'val' => options}
      end

      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Value")
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
