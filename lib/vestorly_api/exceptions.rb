module VestorlyApi
  module Exceptions

    class AuthenticationError < StandardError; end
    class InvalidSignInCredentials < AuthenticationError; end

  end
end
