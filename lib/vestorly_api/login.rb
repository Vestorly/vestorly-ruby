module VestorlyApi
  class Login

    include HTTParty
    extend DefaultEndpoint

    def initialize(username, password)
      @username = username
      @password = password
      @authentication_token = nil
      @login_response = nil
    end

    def login
      @login_response = Login.post( Login.login_api_endpoint, :query => login_query_params )
      if ok_response?
        authentication_token
      else
        raise VestorlyApi::Exceptions::InvalidLoginCredentials
      end
    end

    def authentication_token
      @login_response["vestorly-auth"]
    end

    def self.login_api_endpoint
      "#{Login.default_api_endpoint}/session_management/sign_in?version=#{Login.api_version}"
    end

    def advisor_id
      @login_response["advisor_id"]
    end

    private

    def login_query_params
      {
        :username => @username,
        :password => @password
      }
    end

    def ok_response?
      response_status_code.between?(200, 201)
    end

    def response_status_code
      @login_response.code
    end

    def response_status_message
      @login_response.message
    end
  end
end
