require 'opta/api'

module Opta
  module Soccer
    class SoccerApi < Opta::Api #Opta::Base::BaseApi

      def squads(tournament)
        response_collection('squads', people: 'yes', tmcl: tournament)
      end

      def match_statistics(match)
        response_member('matchstats', match, detailed: 'yes')
      end

      def match_event(match)
        response_member('matchevent', match)
      end

      def match_list(tournament)
        response_collection('match', tmcl: tournament)
      end

      def match(match)
        response_member('match', match)
      end

      def lineups(tournament)
        response_collection('match', tmcl: tournament, live: 'yes', lineup: 'yes')
      end

      def path
        'soccerdata'
      end

    end
  end
end
