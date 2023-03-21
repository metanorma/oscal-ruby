require_relative "serializer"

module Oscal
  class Role
    include Serializer

    KEY = %i(id title short_name description props links remakrs)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Role
      return Role.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Role.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Role")
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
