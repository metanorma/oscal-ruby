require_relative "serializer"

module Oscal
  class ImportObject
    include Serializer

    KEY = %i(href include_all include_controls exclude_controls)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? ImportObject
      return ImportObject.new(obj) unless obj.is_a? Array

      obj.map do |x|
        ImportObject.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in ImportObject")
        end

        val = case key_name
        when 'include_controls'
          IncludeControl.wrap(val)
        when 'exclude_controls'
          ExcludeControl.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
