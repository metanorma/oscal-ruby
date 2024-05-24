require_relative "parsing_functions"

module Oscal
  class Assembly
    include Oscal::ParsingFunctions
    include Serializer

    def mandatory_attributes
      self.class::MANDATORY
    end

    def allowed_attributes
      self.class::MANDATORY + self.class::OPTIONAL
    end

    def input_is_hash?(input)
      unless input.is_a? Hash
        raise Oscal::InvalidTypeError,
              "Assemblies can only be created from Hash types"
      end
    end

    def missing_values?(mandatory, provided)
      puts mandatory, provided
      missing_values = mandatory - provided.keys.intersection(mandatory)
      if missing_values.length.positive?
        raise Oscal::InvalidTypeError,
              "Missing mandatory values: #{missing_values}"
      end
    end

    def extra_values?(allowed, provided)
      extra_values = provided.keys - provided.keys.intersection(allowed)
      if extra_values.length.positive?
        raise Oscal::InvalidTypeError,
              "Extra attributes provided #{extra_values}"
      end
    end

    def validate_input(input)
      missing_values?(mandatory_attributes, input)
      extra_values?(allowed_attributes, input)
    end

    def validate_content(key, value)
      expected_klass = Oscal::get_type_of_attribute(key)
      puts expected_klass
      valid_klass = expected_klass.new(value)
    rescue Oscal::InvalidTypeError
      raise Oscal::InvalidTypeError,
            "Value #{value} could not be instantiated as type #{key}"
    else
      valid_klass # Return the valid class
    end

    def initialize(input)
      # Raise Exception if input is not a hash
      input_is_hash?(input)

      # Transform the keys from Strings to Symbols
      sym_hash = input.transform_keys(&:to_sym)

      # Make sure all required and no extra keys are provided
      validate_input(sym_hash)

      # Attempt to convert each value to it's registered type
      sym_hash.each do |key, value|
        self[key] = validate_content(key, value)
      end
    end
  end
end
