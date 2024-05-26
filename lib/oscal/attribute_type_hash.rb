require_relative("datatypes")
require_relative("list")

module Oscal
  module AssessmentResult
    ATTRIBUTE_TYPE_HASH = {
      activities: ActivityArray,
      activity_uuid: Uuid,
      assessment_platforms: AssessmentPlatformArray,
      assessment_log: AssessmentLog,
      associated_activities: AssociatedActivityArray,
      attestations: AttestationArray,
      collected: DateTimeWithTimezoneDataType,
      components: ComponentArray,
      control_id: TokenDataType,
      control_objective_selections: ControlObjectiveSelectionArray,
      control_selections: ControlSelectionArray,
      description: MarkupMultilineDataType,
      end: DateTimeWithTimezoneDataType,
      entries: EntryArray,
      exclude_controls: ExcludeControlArray,
      exclude_objectives: ExcludeObjectiveArray,
      expires: DateTimeWithTimezoneDataType,
      findings: FindingArray,
      href: UriReference,
      implementation_statement_uuid: Uuid,
      import_ap: ImportAP,
      include_all: IncludeAll,
      include_controls: IncludeControlArray,
      inventory_items: InventoryItemArray,
      links: LinkArray,
      local_definitions: LocalDefinitions,
      metadata: MetadataBlock,
      methods: MethodArray,
      objective_id: TokenDataType,
      objectives_and_methods: ObjectivesAndMethodsArray,
      observations: ObservationArray,
      observation_uuid: Uuid,
      parts: PartArray,
      party_uuids: PartyUuidArray,
      props: PropArray,
      related_controls: RelatedControls,
      related_observations: RelatedObservationArray,
      related_risks: RelatedRiskArray,
      remarks: MarkupMultilineDataType,
      responsible_roles: ResponsibleRoleArray,
      results: ResultArray,
      reviewed_controls: ReviewedControls,
      risks: RiskArray,
      risk_uuid: Uuid,
      role_id: TokenDataType,
      start: DateTimeWithTimezoneDataType,
      state: TokenDataType,
      status: Status,
      statement: MarkupMultilineDataType,
      statement_ids: StatementIdArray,
      steps: StepArray,
      subjects: SubjectArray,
      subject_uuid: Uuid,
      target: Target,
      target_id: TokenDataType,
      tasks: AssessmentTaskArray,
      title: MarkupMultilineDataType,
      type: TokenDataType,
      types: TypeArray,
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
