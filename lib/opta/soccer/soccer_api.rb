require 'opta/api'

module Opta
  module Soccer
    class SoccerApi < Opta::Api

      def squads(tournament)
        response_collection('squads', people: 'yes', tmcl: tournament, _pgSz: 1000)
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
