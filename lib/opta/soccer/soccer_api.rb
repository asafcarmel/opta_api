require 'opta/api'

module Opta
  module Soccer
    class SoccerApi < Opta::Api

      def match_statistics(match)
        response_member('matchstats', match, detailed: 'yes')
      end

      # def lineups(tournament)
      #   response_collection('match', tmcl: tournament, live: 'yes', lineups: 'yes')
      # end

      def path
        'soccerdata'
      end

    end
  end
end
