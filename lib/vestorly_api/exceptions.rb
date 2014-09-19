module VestorlyApi
  module Exceptions

    class Error < StandardError; end
    class AuthenticationError < Error; end
    class InvalidSignInCredentials < Error; end
    class InvalidURIError < Error; end

  end
end
