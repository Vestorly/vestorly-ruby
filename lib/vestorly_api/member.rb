module VestorlyApi
  class Member < AdvisorBase

    DEFAULT_ACTION = 'members.json'.freeze
    FETCH_DEFAULT_ACTION = 'advisor_user_entries.json'.freeze

    def fetch(qury_params={})
      response = get_request(FETCH_DEFAULT_ACTION, qury_params)
      if Member.ok_response?(response)
        response['members']
      else
        raise VestorlyApi::Exceptions::Error
      end
    end

    def create(member_params={})

    end
  end
end
