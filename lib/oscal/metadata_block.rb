require_relative "base_class"

module Oscal
  class MetadataBlock < Oscal::BaseClass
    KEY = %i(title published last_modified version
             oscal_version revisions document_ids props links roles
             locations parties responsible_parties remarks)

    attr_accessor *KEY

    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when "revisions"
        Revision.wrap(val)
      when "docuement_ids"
        DocumentId.wrap(val)
      when "props"
        Property.wrap(val)
      when "links"
        Link.wrap(val)
      when "roles"
        Role.wrap(val)
      when "locations"
        Location.wrap(val)
      when "parties"
        Party.wrap(val)
      when "responsible_parties"
        ResponsibleParty.wrap(val)
      else
        val
      end
    end
  end
end
