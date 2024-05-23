module Oscal
  module OscalDatatype
    def validate
      unless @pattern.match?(@value)
        raise Oscal::InvalidTypeError
      end

      def to_s
        @value
      end
    end
  end

  class UriReference
    include Oscal::OscalDatatype
    def initialize(value)
      @pattern = /[a-zA-Z][a-zA-Z0-9+\-.]+:.*\S/
      @value = value
      validate
    end
  end

  class MarkupMultiline
    include Oscal::OscalDatatype
    def initialize(value)
      @pattern = /.*/ # Note that there are complex rules for MarkupMultiline that we are ignoring
      @value = value
      validate
    end
  end
end
