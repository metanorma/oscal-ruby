module Oscal
  class InsertControl
    KEY = %i(order include_all include_controls exclude_controls)
    attr_accessor *KEY

    def self.wrap(obj)
      return obj if obj.is_a? InsertControl
      return InsertControl.new(obj) unless obj.is_a? Array

      obj.map do |x|
        InsertControl.wrap(x)
      end
    end

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in InsertControl")
        end

        val = case key_name
        when 'include_controls'
          IncludeControl.wrap(val)
        when 'exclude_controls'
          ExcludeControls.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
