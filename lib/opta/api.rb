require 'opta/opta'

module Opta
  class Api
    include Opta::Response

    attr_accessor :token

    def initialize(token)
      self.token = token
    end

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

  end
end
