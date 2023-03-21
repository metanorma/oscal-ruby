require_relative "serializer"

module Oscal
  class Revision
    include Serializer

    KEY = %i(title published last_modified version oscal_version
      props links remarks)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Revision
      return Revision.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Revision.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Revision")
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
