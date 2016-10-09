require 'opta/xml_translator'
require 'opta/string_converter'

module Opta
  module Base
    class Player < Struct.new(:people_id, :first_name, :last_name, :match_name, :date_of_birth, :place_of_birth, :country_of_birth, :nationality, :position)
      extend  Opta::XmlTranslator
      include Opta::StringConverter

      def self.xml_path
        '/datasportsgroup/team/people'
      end

      def self.xml_name
        'people'
      end

      def enforce_attributes_type
        begin
          string_to_datetime(:date_of_birth)
        rescue => exception
          self.date_of_birth = nil
        end
      end
    end
  end
end
