require_relative "serializer"
require_relative "common_utils"

module Oscal
  class Profile
    include Serializer
    include CommonUtils

    KEY = %i(uuid metadata imports merge modify back_matter)
    attr_accessor *KEY

    attr_serializable *KEY

    def initialize(uuid, metadata, imports, merge, modify, back_matter)
      @uuid        = uuid
      @metadata    = MetadataBlock.new(metadata)
      @imports     = ImportObject.wrap(imports) if imports
      @merge       = Merge.wrap(merge) if merge
      @modify      = Modify.wrap(modify) if modify
      @back_matter = BackMatter.wrap(back_matter) if back_matter
    end

    def self.load_from_yaml(path)
      yaml_data     = safe_load_yaml(path)
      yaml_profile  = yaml_data["profile"]

      uuid          = yaml_profile["uuid"]
      metadata      = yaml_profile["metadata"]
      imports       = yaml_profile["imports"]
      merge         = yaml_profile["merge"]
      modify        = yaml_profile["modify"]
      back_matter   = yaml_profile["back-matter"]

      Profile.new(uuid, metadata, imports, merge, modify, back_matter)
    end
  end
end
