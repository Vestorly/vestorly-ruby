module VestorlyApi
  module DefaultEndpoint

    extend self

    def base_api_uri
      "https://www.vestorly.com"
    end

    def default_api_endpoint
      "#{base_api_uri}/api/v#{api_version}"
    end

    def api_version
      1
    end
  end
end
