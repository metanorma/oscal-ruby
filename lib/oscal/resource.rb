require_relative "serializer"

module Oscal
  class Resource
    include Serializer

    KEY = %i(uuid title description props docuement_ids citation rlinks base64
      remarks)

    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Resource
      return Resource.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Resource.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Resource")
        end

        val = case key_name
        when 'props'
          Property.wrap(val)
        when 'document_ids'
          DocumentId.wrap(val)
        when 'citation'
          Citation.wrap(val)
        when 'rlinks'
          Rlink.wrap(val)
        when 'base64'
          Base64Object.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
