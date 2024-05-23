module Oscal
  class Assembly
    def key2var(key)
      if key.is_a?(Symbol)
        key.to_s.gsub("-", "_").gsub("class", "klass")
      else
        key
      end
    end

    def var2key(var)
      if var.is_a?(String)
        var.gsub("-", "_").gsub("class", "klass").to_sym
      else
        var
      end
    end

    def input_is_hash?(input)
      unless input.is_a? Hash
        raise Oscal::InvalidTypeError,
              "Assemblies can only be created from Hash types"
      end
    end

    def missing_or_extra_values?(mandatory, optional, provided)
      provided_key = var2key(provided.each_key.to_a)
      missing_values = mandatory - provided_key.intersection(mandatory)
      if missing_values.positive?
        raise Oscal::InvalidTypeError,
              "Missing mandatory values: #{missing_values}"
      end
      extra_values = provided - provided_key.intersection(mandatory + optional)
      if extra_values.positive?
        raise Oscal::InvalidTypeError,
              "Extra attributes provided #{extra_values}"
      end
    end

    def validate_content(key, value)
      expected_klass = Oscal::get_type_of_attribute(key)
      valid_klass = expected_klass.new(value)
    rescue Oscal::InvalidTypeError
      raise Oscal::InvalidTypeError,
            "Value #{value} could not be instantiated as type #{key}"
    else
      valid_klass # Return the valid class
    end

    def initialize(values)
      # We require a hash for all of these, since simple datatypes have their
      # own class definition (datatypes.rb)
      input_is_hash?(values)

      begin
        # Make sure all required values are present
        missing_or_extra_values?(self.class::MANDATORY, self.class::OPTIONAL,
                                 provided_values)

        # Attempt to convert each value to it's registered type
        values.each do |key, value|
          self[key] = validate_content(key, value)
        end
      rescue Oscal::InvalidTypeError
        raise Oscal::InvalidTypeError
      end
    end
  end
end
