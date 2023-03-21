require_relative "serializer"

module Oscal
  class Link
    include Serializer

    KEY = %i(href rel media_type text)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Link
      return Link.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Link.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Property")
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
