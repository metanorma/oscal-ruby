require_relative("datatypes")
require_relative("list")

module Oscal
  module AssessmentResult
    ATTRIBUTE_TYPE_HASH = {
      activities: ActivityArray,
      assessment_platforms: AssessmentPlatformArray,
      assessment_log: AssessmentLog,
      attestations: AttestationArray,
      components: ComponentArray,
      control_id: Token,
      control_objective_selections: ControlObjectiveSelectionArray,
      control_selections: ControlSelectionArray,
      description: MarkupMultiline,
      end: DateTimeWithTimezone,
      entries: EntryArray,
      exclude_controls: ExcludeControlArray,
      exclude_objectives: ExcludeObjectiveArray,
      href: UriReference,
      import_ap: ImportAP,
      include_all: IncludeAll,
      include_controls: IncludeControlArray,
      inventory_items: InventoryItemArray,
      links: LinkArray,
      local_definitions: LocalDefinitions,
      metadata: MetadataBlock,
      objective_id: Token,
      objectives_and_methods: ObjectivesAndMethodsArray,
      observations: ObservationArray,
      parts: PartArray,
      party_uuids: PartyUuidArray,
      props: PropArray,
      related_controls: RelatedControls,
      remarks: MarkupMultiline,
      responsible_roles: ResponsibleRoleArray,
      results: ResultArray,
      reviewed_controls: ReviewedControls,
      risks: RiskArray,
      role_id: Token,
      start: DateTimeWithTimezone,
      statement_ids: StatementIdArray,
      steps: StepArray,
      tasks: AssessmentTaskArray,
      title: MarkupMultiline,
      uuid: Uuid,
      users: UserArray,
    }.freeze
  end

  def self.get_type_of_attribute(attribute_name)
    klass = Oscal::AssessmentResult::ATTRIBUTE_TYPE_HASH[attribute_name.to_sym]
    if klass == nil
      raise InvalidTypeError, "No type found for #{attribute_name}"
    else
      klass
    end
  end
end
