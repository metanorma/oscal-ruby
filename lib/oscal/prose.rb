require_relative "serializer"

module Oscal
  class Prose
    include Serializer

    attr_serializable :value, :media_type

    def to_xml(builder)
      builder.prose(value, { "media-type" => media_type })
    end
  end
end
