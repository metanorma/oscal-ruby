require_relative "serializer"

module Oscal
  class IncludeControl
    include Serializer

    KEY = %i(with_child_controls with_ids matching)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? IncludeControl
      return IncludeControl.new(obj) unless obj.is_a? Array

      obj.map do |x|
        IncludeControl.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in IncludeControl")
        end

        val = case key_name
        when 'with_ids'
          WithId.wrap(val)
        when 'matching'
          Matching.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
