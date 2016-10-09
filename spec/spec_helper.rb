$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'opta/api'
require 'webmock/rspec'
require 'vcr'

def get_token
  ENV['OPTA_TOKEN']
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.preserve_exact_body_bytes { true }
  c.configure_rspec_metadata!

  ##
  # Filter the real API key so that it does not make its way into the VCR cassette

  c.filter_sensitive_data('<OPTA_TOKEN>')     { get_token }
end
