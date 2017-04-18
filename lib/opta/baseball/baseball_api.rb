require 'opta/api'

module Opta
  module Baseball
    class BaseballApi < Opta::Api

      def match_statistics(match)
        super['matchStats']
      end

      def path
        'baseballdata'
      end

    end
  end
end
