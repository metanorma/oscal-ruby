require_relative "serializer"

require "date"

module Oscal
  class Catalog
    include Serializer

    KEY = %i(uuid metadata params controls groups back_matter)
    attr_accessor *KEY
    attr_serializable *KEY

    def initialize(uuid, metadata, params, controls, groups, back_matter)
      @uuid        = uuid
      @metadata    = MetadataBlock.new(metadata)
      @params      = Parameter.wrap(params) if params
      @controls    = Control.wrap(controls) if controls
      @groups      = Group.wrap(groups) if groups
      @back_matter = BackMatter.wrap(back_matter) if back_matter
    end

    def self.load_from_yaml(path)
      yaml_data     = safe_load_yaml(path)
      yaml_catalog  = yaml_data["catalog"]

      uuid          = yaml_catalog['uuid']
      metadata      = yaml_catalog['metadata']
      params        = yaml_catalog['params']
      controls      = yaml_catalog['controls']
      groups        = yaml_catalog['groups']
      back_matter   = yaml_catalog['back-matter']

      Catalog.new(uuid, metadata, params, controls, groups, back_matter)
    end

    # Psych >= 4 requires permitted_classes to load such classes
    # https://github.com/ruby/psych/issues/533
    def self.safe_load_yaml(path)
      YAML.load_file(
        path,
        permitted_classes: [::Time, ::Date, ::DateTime],
      )
    rescue ArgumentError
      YAML.load_file(path)
    end
  end
end
