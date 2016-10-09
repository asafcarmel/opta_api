require 'opta/api'
require 'opta/base/team'
require 'opta/base/player'

module Opta
  module Base
    class BaseApi < Opta::Api

      def path_prefix
        ""
      end

      def squads(season_id)
        xml = response_xml(path_prefix + '/get_season_team', season_id: season_id)
        return Team.to_list(xml)
      end

      private

      def response_xml(url, properties)
        response = self.generic_request(url, properties)
        Nokogiri::XML(response.to_s)
      end
    end
  end
end
