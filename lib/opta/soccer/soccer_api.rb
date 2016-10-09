require 'opta/api'

module Opta
  module Soccer
    class SoccerApi < Opta::Api #Opta::Base::BaseApi

      def squads(tournament)
        response_collection('squads', people: 'yes', tmcl: tournament)
      end

      def match_statistics(match_id)
        response_member('matchstats', match_id, detailed: 'yes')
      end

      def match_event(match_id)
        response_member('matchevent', match_id)
      end

      def path
        'soccerdata'
      end

    end
  end
end
