require 'opta/version'
require 'opta/exception'
require 'json'
require 'rest_client'

module Opta
  module Response
    def get_member_uri(sport, feed, id)
      "http://api.performfeeds.com/#{sport}/#{feed}/#{self.token}/#{id}"
    end

    def get_collection_uri(sport, feed)
      "http://api.performfeeds.com/#{sport}/#{feed}/#{self.token}"
    end

    def get_params(params)
      p = params || {}
      p.merge(_fmt: 'json')
      #p.merge(_rt: 'b', _fmt: 'json')
    end

    def response_member(feed, id, params=nil)
      response_json(get_member_uri(self.path, feed, id), params)
    end

    def response_collection(feed, params=nil)
      response_json(get_collection_uri(self.path, feed), params)
    end

    def response_json(url, params)
      response = generic_request(url, get_params(params), :json)
      JSON.parse(response.to_s)
    end

    def generic_request(url, params, accept)
      begin
        RestClient.proxy = 'http://52.45.43.141:3128'
        return RestClient.get(url, params: params)
      rescue RestClient::RequestTimeout => timeout
        raise Opta::Exception, 'The API did not respond in a reasonable amount of time'
      rescue RestClient::Exception => e
        raise Opta::Exception, e.response.to_s
      end
    end
  end
end
