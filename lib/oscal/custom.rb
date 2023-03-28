require_relative "serializer"

module Oscal
  class Custom
    include Serializer

    KEY = %i(groups insert_controls)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Custom
      return Custom.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Custom.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Custom")
        end

        val = case key_name
        when 'groups'
          Group.wrap(val)
        when 'insert_controls'
          InsertControl.wrap(val)
        else
          val
        end

        send("#{key_name}=", val)
      end
    end
  end
end
