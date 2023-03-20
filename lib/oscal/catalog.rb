module Oscal
  class Catalog
    attr_accessor :uuid, :metadata, :groups

    def initialize(metadata, groups)
      @metadata = MetadataBlock.new(metadata)
      @groups = Group.wrap(groups)
    end

    def self.load_from_yaml(path)
      yaml_data = YAML.load_file(path, permitted_classes: [Time, Date, DateTime])

      yaml_catalog = yaml_data['catalog']

      metadata = yaml_catalog['metadata']
      group_data = yaml_catalog['groups']

      Catalog.new(metadata, group_data)
    end
  end

end
