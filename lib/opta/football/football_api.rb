require 'opta/api'

module Opta
  module Football
    class FootballApi < Opta::Api

      def path
        'footballdata'
      end

      def match_statistics(match)
        response_member('matchstats', match)
      end

    end
  end
end
