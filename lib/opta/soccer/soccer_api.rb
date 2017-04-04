require 'opta/api'

module Opta
  module Soccer
    class SoccerApi < Opta::Api
      CassettesFolder = "#{Dir.home}/apps/cassettes"
      DateFormat = '%Y-%m-%d_%H_%M_%S'

      def match_statistics(match)
        feed = 'matchstats'
        file_name = get_vcr_file_name(feed, match)
        return super if file_name.nil?
        run_in_vcr(feed, match, file_name) { return response_member(feed, match, detailed: 'yes') }
      end

      def match_event(match)
        feed = 'matchevent'
        file_name = get_vcr_file_name(feed, match)
        return super if file_name.nil?
        resp = nil
        run_in_vcr(feed, match, file_name) { resp = response_member(feed, match) }
        offset = time_offset
        resp['liveData']['event'].each {|event| fix_timestamp(event, offset) }

        resp
      end


      def run_in_vcr(feed, match, file_name)
        VCR.configure do |c|
          c.hook_into :webmock
          c.cassette_library_dir = CassettesFolder
          c.allow_http_connections_when_no_cassette = true
          c.filter_sensitive_data("\xEF\xBB\xBF") { '' }
          c.before_record { |i| i.response.body.force_encoding('UTF-8') }
        end
        VCR.use_cassette(file_name, record: :none, match_requests_on: [:uri], serialize_with: :yaml, decode_compressed_response: true) do
          yield
        end
      end

      def time_offset
        ENV["TIME_OFFSET_SEC"].to_i
      end

      def get_vcr_file_name(feed, match)
        times   = get_feed_times(feed, match)
        return nil if times.blank?
        current = find_current_time(times)
        build_file_name(feed, match, current)
      end

      def build_file_name(feed, match, current)
        prefix = filename_prefix(feed, match)
        time_string = (current - time_offset).strftime(DateFormat)
        "#{prefix}#{time_string}_0000"
      end

      def filename_prefix(feed, match)
        "#{feed}_#{match}_"
      end

      def find_current_time(times)
        now   = Time.now.utc
        range = times.find{|time_range| time_range.cover?(now)}
        range.first
      end

      def get_feed_times(feed, match)
        key = filename_prefix(feed, match)
        build_time_ranges(feed, match)
      end

      def build_time_ranges(feed, match)
        filename_prefix = self.filename_prefix(feed, match)
        offset = time_offset
        path = "#{CassettesFolder}/#{filename_prefix}"
        suffix = '.yml'
        slice_range = path.length..-(suffix.length+1)

        files = Dir.glob("#{path}*").sort

        times = files.map{ |file_name| file_name.slice(slice_range) }
        times = times.map{ |file_time| (DateTime.strptime(file_time, DateFormat).to_time.utc) + offset}.sort

        times_to_ranges(times)
      end

      def times_to_ranges(times)
        hours_24 = 24*60*60
        times.each_with_index.map do |file_time, i|
          next_file_time = ((i+1) < times.length) ? times[i+1] : (times.last + hours_24)
          file_time..next_file_time
        end
      end

      def fix_timestamp(event, offset)
        timestamp = Time.parse(event["timeStamp"]) + offset
        event["timeStamp"] = timestamp.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
      end

      def path
        'soccerdata'
      end


    end
  end
end
