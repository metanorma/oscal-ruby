require "date"

module Oscal
  class Catalog
    attr_accessor :uuid, :metadata, :groups

    def initialize(metadata, groups)
      @metadata = MetadataBlock.new(metadata)
      @groups = Group.wrap(groups)
    end

    def self.load_from_yaml(path)
      yaml_data = safe_load_yaml(path)
      yaml_catalog = yaml_data["catalog"]

      metadata = yaml_catalog["metadata"]
      group_data = yaml_catalog["groups"]

      Catalog.new(metadata, group_data)
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
