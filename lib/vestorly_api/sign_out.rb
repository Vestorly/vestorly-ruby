module VestorlyApi
  class SignOut

    include HTTParty
    extend DefaultEndpoint

    def initialize(authentication_token)
      @authentication_token = authentication_token
      @sign_out_response = nil
    end

    def self.sign_out_api_endpoint
      "#{SignOut.default_api_endpoint}/session_management/sign_out?version=#{SignOut.api_version}"
    end

    def self.sign_out(authentication_token)
      new(authentication_token).sign_out
    end

    def sign_out
      @sign_out_response = SignOut.post( SignOut.sign_out_api_endpoint, query: default_query_params )
      sign_out_response
    end

    private

    def default_query_params
      {
        "vestorly-auth" => @authentication_token
      }
    end

    def sign_out_response
      {
        code: response_status_code,
        message: response_message
      }
    end

    def response_status_code
      @sign_out_response.code
    end

    def response_message
      @sign_out_response["message"]
    end

  end
end
