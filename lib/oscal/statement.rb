module Oscal
  class Statement
    attr_accessor :description, :prose, :properties

    def initialize(description, prose, properties)
      @description = description
      @prose = prose
      @properties = properties
    end
  end
end
