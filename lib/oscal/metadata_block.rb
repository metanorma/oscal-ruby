module Oscal
  class MetadataBlock
    METADATA_VALUES = %i(title published last_modified version
      oscal_version remarks
      revisions document_ids props links roles
      locations parties responsible_parties)

    attr_accessor *METADATA_VALUES

    def initialize(options = {})
      options.each_pair.each do |key, val|
        key_name = key.gsub("-", "_")

        unless METADATA_VALUES.include?(key_name.to_sym)
          raise UnknownAttributeError.new(
            "Unknown key `#{key}` in MetadataBlock",
          )
        end

        val = case key_name
        when 'revisions'
          Revision.wrap(val)
        when 'docuement_ids'
          DocumentId.wrap(val)
        when 'props'
          Property.wrap(val)
        when 'links'
          Link.wrap(val)
        when 'roles'
          Role.wrap(val)
        when 'locations'
          Location.wrap(val)
        when 'parties'
          Party.wrap(val)
        when 'responsible_parties'
          ResponsibleParty.wrap(val)
        else
          val
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end
