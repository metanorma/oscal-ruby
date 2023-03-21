require_relative "serializer"

module Oscal
  class DocumentId
    include Serializer

    KEY = %i(schema identifier)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? DocumentId
      return DocumentId.new(obj) unless obj.is_a? Array

      obj.map do |x|
        DocumentId.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in DocumentId")
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
