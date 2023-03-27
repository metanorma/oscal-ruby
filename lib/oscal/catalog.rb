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

      @all_controls = []
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

    def get_all_controls
      append_all_control_group(self)
      @all_controls.uniq
    end

    def append_all_control_group(obj)
      if obj.to_s.match(/Oscal::Control/)
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

    def find_object_by_id(id, obj = self, attribute_name = :id)
      if obj.respond_to?(attribute_name) && obj.send(attribute_name) == id
        return obj
      end

      res = nil

      obj.instance_variables.each do |ins_var|
        val = obj.send(ins_var.to_s.delete('@').to_sym)

        if val.is_a? Array
          val.each do |v|
            res = find_object_by_id(id, v, attribute_name.to_sym)
            break unless res.nil?
          end
        else
          res = find_object_by_id(id, val, attribute_name.to_sym)
        end

        break unless res.nil?
      end

      res
    end
  end
end
