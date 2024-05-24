module Oscal
  module OscalDatatype
    include ParsingLogger

    def validate(value)
      @logger.debug("validating against pattern #{self.class::PATTERN}")
      unless self.class::PATTERN.match?(value)
        raise Oscal::InvalidTypeError,
              "#{value.to_s[0, 25]} does not match Pattern for #{self.class}"
      end
    end

    def initialize(input)
      @logger = get_logger
      @logger.debug("#{self.class}.new called with #{input.to_s[0, 25]}")
      validate(input) # Will raise an Error if invalid
      @logger.debug("validation successful.")
      @value = input
    end

    def to_s
      @value
    end
  end

  class UriReference
    include OscalDatatype
    PATTERN = %r{^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?}
  end

  class MarkupMultiline
    include OscalDatatype
    # Note that there are complex rules for MarkupMultiline that we are ignoring
    PATTERN = /.*/
  end

  class Token
    include OscalDatatype
    PATTERN = /(\p{L}|_)(\p{L}|\p{N}|[.\-_])*/
  end

  class Uuid
    include OscalDatatype
    PATTERN = /^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[45][0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12}$/
  end

  class DateTimeWithTimezone
    include OscalDatatype
    PATTERN = /(((2000|2400|2800|(19|2[0-9](0[48]|[2468][048]|[13579][26])))-02-29)|(((19|2[0-9])[0-9]{2})-02-(0[1-9]|1[0-9]|2[0-8]))|(((19|2[0-9])[0-9]{2})-(0[13578]|10|12)-(0[1-9]|[12][0-9]|3[01]))|(((19|2[0-9])[0-9]{2})-(0[469]|11)-(0[1-9]|[12][0-9]|30)))T(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\.[0-9]+)?(Z|(-((0[0-9]|1[0-2]):00|0[39]:30)|\+((0[0-9]|1[0-4]):00|(0[34569]|10):30|(0[58]|12):45)))/
  end
end
