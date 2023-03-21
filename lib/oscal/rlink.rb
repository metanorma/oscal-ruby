require_relative "serializer"

module Oscal
  class Rlink
    include Serializer

    KEY = %i(href media_type hashes)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Rlink
      return Rlink.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Rlink.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Property")
        end

        val = case key_name
        when 'hashes'
          HashObject.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
