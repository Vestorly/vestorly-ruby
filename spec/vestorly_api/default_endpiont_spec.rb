require 'spec_helper'

describe VestorlyApi::DefaultEndpoint do

  subject { VestorlyApi::DefaultEndpoint }

  describe 'default values for API' do
    it 'gives the base url to Vestorly endpoint' do
      subject.base_api_uri.should eq('https://api.vestorly.com/')
    end

    it 'gives the base Vestory API endpoint' do
      subject.default_api_endpoint.should eq('https://api.vestorly.com/api/v1')
    end

    it 'gives the Vestorly API version' do
      subject.api_version.should eq(1)
    end
  end
end
