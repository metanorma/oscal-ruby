require_relative "serializer"

module Oscal
  class Remove
    include Serializer

    KEY = %i(by_name by_class by_id by_item_name by_ns)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Remove
      return Remove.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Remove.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Remove")
        end

        send("#{key_name}=", val)
      end
    end
  end
end
