require 'spec_helper'

describe VestorlyApi::SignIn do

  def api_request_helper(requester, request_params)
    requester.post(
      requester.sign_in_api_endpoint,
      query: request_params
    )
  end

  describe 'default attributes' do

    subject { described_class }

    it 'should include httparty methods' do
      subject.should include(HTTParty)
    end

    it 'should have the base url set to the VestorlyApi API endpoint' do
      subject.sign_in_api_endpoint.should eq('https://vestorly-dev.herokuapp.com/api/v1/session_management/sign_in?version=1')
    end
  end

  describe 'sign_in api' do
    describe "POST sign_in" do

      describe "with valid authentication" do

        let(:username) { 'david@vestorly.com' }
        let(:password) { '12desbrosses' }

        let(:request_params) { {
          username: username,
          password: password
        }}

        subject { described_class }

        before do
          VCR.insert_cassette 'sign_in', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it 'records the fixture' do
          api_request_helper(subject, request_params)
        end

        it 'makes sign_in request to api returns authentication token' do
          sign_in_api = described_class.new(username, password)
          sign_in_api.sign_in.should eq("eyJwYXlsb2FkIjoiNTM0ZDllYmZiMDM0ZDUwMDAyMDAwNGZkIiwiY3JlYXRlZF9vbiI6MTQxMTA4Mzg0Niwic2lnbmF0dXJlIjoiVUZtcmU5REZUb0V1KzNBY2dTajdGRTJlZVJ2REl0S0Nmbm1Mbzh5cWpIVT0ifQ")
        end

        it 'assigns api response for further use' do
          sign_in_api = described_class.new(username, password)
          sign_in_api.sign_in
          sign_in_api.instance_variable_get('@sign_in_response').should_not be_nil
        end

        it 'gives authentication token after sign_in' do
          sign_in_api = described_class.new(username, password)
          sign_in_api.sign_in
          sign_in_api.authentication_token.should eq("eyJwYXlsb2FkIjoiNTM0ZDllYmZiMDM0ZDUwMDAyMDAwNGZkIiwiY3JlYXRlZF9vbiI6MTQxMTA4Mzg0Niwic2lnbmF0dXJlIjoiVUZtcmU5REZUb0V1KzNBY2dTajdGRTJlZVJ2REl0S0Nmbm1Mbzh5cWpIVT0ifQ")
        end

        it 'gives the advisor id' do
          sign_in_api = described_class.new(username, password)
          sign_in_api.sign_in
          sign_in_api.advisor_id.should eq("rodas")
        end
      end

      describe "with invalid authentication" do
        let(:username) { 'invalid@example.com' }
        let(:password) { 'nonexistingdude' }

        let(:request_params) { {
          username: username,
          password: password
        }}

        subject { described_class }

        before do
          VCR.insert_cassette 'invalid_sign_in', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it 'records the fixture' do
          api_request_helper(subject, request_params)
        end

        it 'raise unauthorized sign_in error' do
          sign_in_api = described_class.new(username, password)
          expect { sign_in_api.sign_in }.to raise_error( VestorlyApi::Exceptions::Error )
        end

      end

    end
  end
end
