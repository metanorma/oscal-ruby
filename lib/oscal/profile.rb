module Oscal
  class Profile
    attr_accessor :metadata, :imports, :controls

    def initialize(metadata, imports, controls)
      @metadata = metadata
      @imports = imports
      @controls = controls
    end
  end
end
