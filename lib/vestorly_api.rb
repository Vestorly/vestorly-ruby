require 'httparty'

require 'vestorly_api/version'
require 'vestorly_api/exceptions'
require 'vestorly_api/default_endpoint'

require 'vestorly_api/response_utils'

require 'vestorly_api/sign_in'
require 'vestorly_api/sign_out'

require 'vestorly_api/advisor_base'
require 'vestorly_api/member'

module VestorlyApi
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
    raise VestorlyApi::Exceptions::InvalidURIError if (config.api_uri =~ URI::regexp).nil?
    config.api_uri << '/' unless config.api_uri[-1, 1] == '/'
  end

  class Configuration
    attr_accessor :api_uri
  end
end
