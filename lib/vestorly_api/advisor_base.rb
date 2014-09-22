module VestorlyApi
  class AdvisorBase

    include HTTParty
    extend DefaultEndpoint
    extend ResponseUtils

    def initialize(authenticated_sign_in)
      @authenticated_sign_in = authenticated_sign_in
      @query_params
    end

    def self.advisor_api_endpoint
      "#{AdvisorBase.default_api_endpoint}/advisors"
    end

    def action_api_endpoint(request_action)
      "#{AdvisorBase.advisor_api_endpoint}/#{@authenticated_sign_in.advisor_id}/#{request_action}"
    end

    def members(query_params={})
      members_response = get_request('advisor_user_entries.json', query_params)
      return members_response['members'] if members_response.key?('members')
      return members_response
    end

    def advisor_posts(query_params={})
      get_request('posts.json', query_params)
    end

    def create_member(post_params={})
      post_request('members.json', { member: post_params })
      return new_member['member'] if new_member.response.code == '201'
      return new_member
    end

    protected

    # TODO: refactor this to a query object
    def post_request(request_action, query_params={})
      AdvisorBase.post( action_api_endpoint(request_action), :query => request_query_params(query_params))
    end

    def get_request(request_action, query_params={})
      AdvisorBase.get( action_api_endpoint(request_action), :query => request_query_params(query_params))
    end

    def put_request(request_action, query_params={})
      AdvisorBase.put( action_api_endpoint(request_action), :query => request_query_params(query_params))
    end

    def delete_request(request_action, query_params={})
      AdvisorBase.put( action_api_endpoint(request_action), :query => request_query_params(query_params))
    end

    def request_query_params(query_params={})
      default_query_params.merge(query_params)
    end

    def default_query_params
      {
        "vestorly-auth" => @authenticated_sign_in.authentication_token
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
