require_relative "serializer"

module Oscal
  class Select
    include Serializer

    KEY = %i(how_many choice)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Select
      return Select.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Select.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Select")
        end

        val = case key_name
        when 'choice'
          Choice.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
