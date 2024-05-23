module Oscal
  module ParsingFunctions
    def sym2str(key)
      if key.is_a?(Symbol)
        key.to_s.gsub("-", "_").gsub("class", "klass")
      end
    end

    def str2sym(var)
      if var.is_a?(String)
        var.gsub("-", "_").gsub("class", "klass").to_sym
      end
    end

    def str_sym_converter(var)
      if key.is_a?(Symbol)
        key.to_s.gsub("-", "_").gsub("class", "klass")
      elsif var.is_a?(String)
        var.gsub("-", "_").gsub("class", "klass").to_sym
      end
    end
  end
end
