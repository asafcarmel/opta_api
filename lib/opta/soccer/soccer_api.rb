require 'opta/api'

module Opta
  module Soccer
    class SoccerApi < Opta::Api

      def lineups(tournament)
        response_collection('match', tmcl: tournament, live: 'yes', lineup: 'yes')
      end

      def path
        'soccerdata'
      end

    end
  end
end
