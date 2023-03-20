module Oscal
  class Component
    attr_accessor :id, :name, :type, :description, :properties

    def initialize(id, name, type, description, properties)
      @id = id
      @name = name
      @type = type
      @description = description
      @properties = properties
    end
  end

end