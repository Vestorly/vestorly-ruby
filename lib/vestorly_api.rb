require "httparty"

Dir[File.dirname(__FILE__) + '/vestorly_api/*.rb'].each do |file|
  require file
end

module VestorlyApi

end
