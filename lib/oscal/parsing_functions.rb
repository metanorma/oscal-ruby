module Oscal
  module ParsingFunctions
    def sym2str(key)
      if key.is_a?(Symbol)
        key.to_s.gsub("-", "_").gsub("class", "klass")
      elsif key.is_a?(String)
        key
      end
    end

    def str2sym(var)
      if var.is_a?(String)
        var.gsub("-", "_").gsub("class", "klass").to_sym
      elsif var.is_a?(Symbol)
        var
      end
    end
  end
end
