module VestorlyApi
  module Exceptions

    class AuthenticationError < StandardError; end
    class InvalidLoginCredentials < AuthenticationError; end

  end
end
