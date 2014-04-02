module VestorlyApi
  class Advisor

    include HTTParty
    extend DefaultEndpoint

    def initialize(authenticated_login)
      @authenticated_login = authenticated_login
      @query_params
    end

    def self.advisor_api_endpoint
      "#{Advisor.default_api_endpoint}/advisors"
    end

    def action_api_endpoint(request_action)
      "#{Advisor.advisor_api_endpoint}/#{@authenticated_login.advisor_id}/#{request_action}"
    end

    def advisor_user_entries(query_params={})
      get_request('advisor_user_entries.json', query_params)
    end

    def advisor_posts(query_params={})
      get_request('posts.json', query_params)
    end

    private

    def post_request(request_action, query_params={})
      Advisor.post( action_api_endpoint(request_action), :query => request_query_params(query_params))
    end

    def get_request(request_action, query_params={})
      Advisor.get( action_api_endpoint(request_action), :query => request_query_params(query_params))
    end

    def request_query_params(query_params={})
      default_query_params.merge(query_params)
    end

    def default_query_params
      {
        "vestorly-auth" => @authenticated_login.authentication_token
      }
    end

    def query_params_to_string(query_params_hash)
      query_params_string = ""
      query_params_hash.each do |key, value|
        query_params_string += "&#{key}=#{value}"
      end
      query_params_string
    end
  end
end
