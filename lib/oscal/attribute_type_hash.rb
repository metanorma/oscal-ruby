require_relative("datatypes")

module Oscal
  ATTRIBUTE_TYPE_HASH = {
    activities: ActivityArray,
    assessment_platforms: AssessmentPlatformArray,
    assessment_log: AssessmentLog,
    attestations: AttestationArray,
    components: ComponentArray,
    control_id: Token,
    control_objective_selections: ControlObjectiveSelectionArray,
    control_selections: ControlSelections,
    description: MarkupMultiline,
    end: DateTimeWithTimezone,
    entries: EntryArray,
    exclude_controls: ExcludeControlArray,
    exclude_objectives: ExcludeObjectiveArray,
    href: UriReference,
    include_all: nil, # THIS IS A STRANGE ONE - LIKE A FLAG OR SOMETHING
    include_controls: IncludeControlArray,
    inventory_items: InventoryItemArray,
    links: LinkArray,
    objective_id: Token,
    objectives_and_methods: ObjectivesAndMethodsArray,
    observations: ObservationArray,
    parts: PartArray,
    party_uuids: PartyUuidArray,
    props: PropArray,
    remarks: MarkupMultiline,
    responsible_roles: ResponsibleRoleArray,
    reviewed_controls: ReviewedControls,
    risks: RiskArray,
    role_id: Token,
    start: DateTimeWithTimezone,
    steps: StepArray,
    tasks: AssessmentTaskArray,
    title: MarkupMultiline,
    uuid: Uuid,
    users: UserArray,
  }.freeze

  def self.get_type_of_attribute(attribute_name)
    Oscal::ATTRIBUTE_TYPE_HASH[attribute_name.to_sym]
  end
end
