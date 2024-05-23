require "date"
require_relative "serializer"
require_relative "common_utils"
require_relative "base_class"
require_relative "assembly"

module Oscal
  class Activity < Assembly
    attr_accessor MANDATORY = %i(uuid).freeze,
                  OPTIONAL = %i(title description props links steps
                                related_controls responsible_roles
                                remarks).freeze
  end

  class Attestations < Assembly
  end

  class AssessmentAssets < Assembly
    attr_accessor MANDATORY = %i(assessment_platforms).freeze,
                  OPTIONAL = %i(components).freeze
  end

  class AssessmentLog
    attr_accessor MANDATORY = %i(entries).freeze
  end

  class AssessmentPlatform < Assembly
    # TODO: Define this. Punting for the time being
  end

  class AssessmentTask < Assembly
    # TODO: Define this. Punting for the time being
  end

  class Attestation < Assembly
    # TODO: Define this. Punting for the time being
  end

  class Component < Assembly
    # TODO: Define this. Punting for the time being
  end

  class ControlObjectiveSelection < Assembly
    attr_accessor OPTIONAL = %i(description props links include_all
                                include_objectives exclude_objectives
                                remarks).freeze
  end

  class ControlSelections < Assembly
    attr_accessor OPTIONAL = %i(description props links include_all
                                include_controls exclude_controls
                                remarks).freeze
  end

  class Entry < Assembly
    # TODO: Define this. Punting for the time being
  end

  class ExcludeObjective < Assembly
    attr_accessor MANDATORY = %i(objective_id).freeze
  end

  class Finding < Assembly
    # TODO: Define this. Punting for the time being
  end

  class ImportAP < Assembly
    include Serializer
    attr_accessor MANDATORY = %i(href).freeze,
                  OPTIONAL = %i(remarks).freeze
  end

  class IncludeObjective < Assembly
    attr_accessor MANDATORY = %i(objective_id).freeze
  end

  class InventoryItem < Assembly
    # TODO: Define this. Punting for the time being
  end

  class LocalDefinitions < Assembly
    # NOTE we deviate fromt the spec here! local-definitions is defined twice
    # with different attributes. All attributes are optional, so we merge it
    # into one big back of optional attributes
    attr_accessor OPTIONAL = %i(objectives_and_methods activities
                                remarks components inventory_items users
                                assesssment_assets tasks).freeze
  end

  class ObjectivesAndMethods < Assembly
    attr_accessor MANDATORY = %i(control_id parts).freeze,
                  OPTIONAL = %i(description props links remarks).freeze
  end

  class Observation < Assembly
    # TODO: Define this. Punting for the time being
  end

  class RelatedControls < Assembly
    attr_accessor MANDATORY = %i(control_selections).freeze,
                  OPTIONAL = %i(description props links
                                control_objective_selections remarks).freeze
  end

  class ResponsibleRole < Assembly
    attr_accessor MANDATORY = %i(role_id).freeze,
                  OPTIONAL = %i(props links party_uuids remarks).freeze
  end

  class Result < Assembly
    attr_accessor MANDATORY = %i(uuid title description start).freeze,
                  OPTIONAL = %i(end props links local_definitions
                                reviewed_controls attestations assessment_log
                                observations risks findings remarks).freeze
  end

  class ReviewedControls < Assembly
    attr_accessor MANDATORY = %i(control_selections).freeze,
                  OPTIONAL = %i(description props links
                                control_objective_selections remarks).freeze
  end

  class Risk < Assembly
    # TODO: Define this. Punting for the time being
  end

  class Step < Assembly
    attr_accessor MANDATORY = %i(uuid).freeze,
                  OPTIONAL = %i(title description props links reviewed_controls
                                responsible_roles remarks).freeze
  end

  class Task < Assembly
    # TODO: Define this. Punting for the time being
  end

  class User < Assembly
    # TODO: Define this. Punting for the time being
  end

  ##########################################

  class AssessmentResult
    include Serializer
    include CommonUtils
    KEY = %i(uuid metadata import_ap local_definitions results
             back_matter).freeze
    attr_accessor(*KEY)

    attr_serializable(*KEY)

    def initialize(uuid, metadata, import_ap, local_definitions, results,
                back_matter)
      @uuid = uuid
      @metadata = MetadataBlock.new(metadata)
      @import_ap = ImportAP.new(import_ap)
      @local_definitions = LocalDefinitions.new(local_definitions)
      @results = results
      @back_matter = BackMatter.wrap(back_matter)
    end
  end
end
