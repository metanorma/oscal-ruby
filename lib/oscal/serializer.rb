require "yaml"
require "json"

module Oscal
  module Serializer
    def to_h
      instance_variables.each_with_object({}) do |var, hash|
        var_name = var.to_s.delete("@")
        hash[var_name] = instance_variable_get(var)
      end
    end

    def to_json(*args)
      to_h.to_json(*args)
    end

    def to_yaml
      to_h.to_yaml
    end

    def to_xml(builder)
      raise NotImplementedError, "#{self.class}#to_xml not implemented!"
    end

    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def from_h(data)
        new(*data.values_at(*attribute_names))
      end

      def from_json(json_string)
        data = JSON.parse(json_string)
        from_h(data)
      end

      def from_yaml(yaml_string)
        data = YAML.safe_load(yaml_string)
        from_h(data)
      end

      def from_xml(xml_element)
        raise NotImplementedError, "#{self}#from_xml not implemented!"
      end

      # Psych >= 4 requires permitted_classes to load such classes
      # https://github.com/ruby/psych/issues/533
      def safe_load_yaml(path)
        YAML.load_file(
          path,
          permitted_classes: [::Time, ::Date, ::DateTime],
        )
      rescue ArgumentError
        YAML.load_file(path)
      end

      private

      def attribute_names
        @attribute_names ||= []
      end

      def attr_serializable(*attrs)
        attrs.each do |attr|
          attribute_names << attr.to_sym
          define_method(attr) { instance_variable_get("@#{attr}") }
          define_method("#{attr}=") do |value|
            instance_variable_set("@#{attr}", value)
          end
        end
      end
    end
  end
end
