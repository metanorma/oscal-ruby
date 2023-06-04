require "date"
require_relative "serializer"
require_relative "common_utils"

module Oscal
  class Catalog
    include Serializer
    include CommonUtils

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

      @all_controls = []
    end

    def self.load_from_yaml(path)
      yaml_data     = safe_load_yaml(path)
      yaml_catalog  = yaml_data["catalog"]

      uuid          = yaml_catalog["uuid"]
      metadata      = yaml_catalog["metadata"]
      params        = yaml_catalog["params"]
      controls      = yaml_catalog["controls"]
      groups        = yaml_catalog["groups"]
      back_matter   = yaml_catalog["back-matter"]

      Catalog.new(uuid, metadata, params, controls, groups, back_matter)
    end

    def get_all_controls
      append_all_control_group(self)
      @all_controls.uniq
    end

    def append_all_control_group(obj)
      if /Oscal::Control/.match?(obj.to_s)
        @all_controls << obj
      end

      if obj.respond_to?(:controls) && !obj.controls.nil?
        obj.controls.each do |c|
          append_all_control_group(c)
        end
      end

      if obj.respond_to?(:groups) && !obj.groups.nil?
        obj.groups.each do |g|
          append_all_control_group(g)
        end
      end
    end
  end
end
