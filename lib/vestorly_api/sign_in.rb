module VestorlyApi
  class SignIn

    include HTTParty
    extend DefaultEndpoint

    def initialize(username, password)
      @username = username
      @password = password
      @authentication_token = nil
      @sign_in_response = nil
    end

    def sign_in
      @sign_in_response = SignIn.post( SignIn.sign_in_api_endpoint, query: default_query_params )
      if ok_response?
        authentication_token
      else
        raise VestorlyApi::Exceptions::InvalidSignInCredentials
      end
    end

    def authentication_token
      @sign_in_response["vestorly-auth"]
    end

    def self.sign_in_api_endpoint
      "#{SignIn.default_api_endpoint}/session_management/sign_in?version=#{SignIn.api_version}"
    end

    def advisor_id
      @sign_in_response["advisor_id"]
    end

    private

    def default_query_params
      {
        :username => @username,
        :password => @password
      }
    end

    def ok_response?
      response_status_code.between?(200, 201)
    end

    def response_status_code
      @sign_in_response.code
    end

    def response_status_message
      @sign_in_response.message
    end
  end
end
