require_relative "serializer"

module Oscal
  class BaseClass
    include Serializer

    KEY = %i(val)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      klass = self
      return obj if obj.is_a? klass
      return klass.new(obj) unless obj.is_a? Array

      obj.map do |x|
        klass.wrap(x)
      end
    end

    def initialize(options = {})
      klass = self.class

      unless options.is_a? Hash
        options = {klass::KEY.first.to_s => options}
      end

      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")
        key_name = 'klass' if key == 'class'

        unless klass::KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new(
            "Unknown key `#{key}` in #{klass.name}"
          )
        end

        val = set_value(key_name, val)

        send("#{key_name}=", val)
      end
    end

    def set_value(key_name, val)
      val
    end
  end
end
