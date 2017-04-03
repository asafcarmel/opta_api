require 'opta/api'

module Opta
  module Baseball
    class BaseballApi < Opta::Api

      # def squads(tournament)
      #   response_collection('squads', tmcl: tournament, _pgSz: 1000)
      # end

      # def match_list(tournament)
      #   response_pages('match', tmcl: tournament)
      # end

      def match_statistics(match)
        super['matchStats']
      end

      def path
        'baseballdata'
      end

    end
  end
end
