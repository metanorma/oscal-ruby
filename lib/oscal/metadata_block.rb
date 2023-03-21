module Oscal
  class MetadataBlock
    METADATA_VALUES = %i(title published last_modified version
                         oscal_version remarks).freeze

    attr_accessor *METADATA_VALUES

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless METADATA_VALUES.include?(key_name.to_sym)
          raise UnknownAttributeError.new(
            "Unknown key `#{key}` in MetadataBlock",
          )
        end

        send("#{key_name}=", val)
      end
    end
  end
end
