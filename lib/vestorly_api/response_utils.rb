module VestorlyApi
  module ResponseUtils

    extend self

    def ok_response?(response)
      response_status_code(response).between?(200, 201)
    end

    def response_status_code(response)
      response.code
    end

    def response_status_message(response)
      response.message
    end

  end
end
