require_relative "serializer"

module Oscal
  class Citation
    include Serializer

    KEY = %i(text props links)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Citation
      return Citation.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Citation.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Citation")
        end

        val = case key_name
        when 'props'
          Property.wrap(val)
        when 'links'
          Link.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
