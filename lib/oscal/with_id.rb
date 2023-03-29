require_relative "base_class"

module Oscal
  class WithId < Oscal::BaseClass
    include Serializer

    KEY = %i(val)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? WithId
      return WithId.new(obj) unless obj.is_a? Array

      obj.map do |x|
        WithId.wrap(x)
      end
    end

    def initialize(options = {})
      klass = self.class

      unless options.is_a? Hash
        options = {KEY.first.to_s => options}
      end

      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in #{klass.name}")
        end

        send("#{key_name}=", val)
      end
    end
  end
end
