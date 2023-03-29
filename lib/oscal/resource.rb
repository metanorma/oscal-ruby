require_relative "base_class"

module Oscal
  class Resource < Oscal::BaseClass
    KEY = %i(uuid title description props docuement_ids citation rlinks
      base64 remarks)

    attr_accessor *KEY
    attr_serializable *KEY

    def set_value(key_name, val)
      case key_name
      when 'props'
        Property.wrap(val)
      when 'document_ids'
        DocumentId.wrap(val)
      when 'citation'
        Citation.wrap(val)
      when 'rlinks'
        Rlink.wrap(val)
      when 'base64'
        Base64Object.wrap(val)
      else
        val
      end
    end
  end
end
