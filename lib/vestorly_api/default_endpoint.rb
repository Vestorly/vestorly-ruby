module VestorlyApi
  module DefaultEndpoint

    extend self

    def base_api_uri
      VestorlyApi.config.api_uri
    end

    def default_api_endpoint(version=self.api_version)
      "#{base_api_uri}api/v#{version}"
    end

    def api_version
      1
    end
  end
end
