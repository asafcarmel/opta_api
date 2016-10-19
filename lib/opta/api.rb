require 'opta/opta'

module Opta
  class Api
    include Opta::Response

    attr_accessor :token

    def initialize(token)
      self.token = token
    end

    def squads(tournament)
      response_collection('squads', tmcl: tournament, detailed: 'yes', _pgSz: 1000)
    end

    def match_statistics(match)
      response_member('matchstats', match)
    end

    def match_event(match)
      response_member('matchevent', match)
    end

    def match_list(tournament)
      response_pages('match', tmcl: tournament, live: 'yes')
    end
  end
end
