require 'spec_helper'

describe VestorlyApi::SignOut do
  def api_request_helper(requester, request_params)
    requester.post(
      requester.sign_out_api_endpoint,
      query: request_params
    )
  end

  describe 'default attributes' do

    subject { described_class }

    it 'should include httparty methods' do
      subject.should include(HTTParty)
    end

    it 'should have the base url set to the VestorlyApi API endpoint' do
      subject.sign_out_api_endpoint.should eq('https://www.vestorly.com/api/v1/session_management/sign_out?version=1')
    end

  end

  describe 'sign out api' do
    describe 'POST sign out' do

      describe 'with valid authentication token' do

        let(:authentication_token) { "eyJwYXlsb2FkIjoiNGY2NTQyYzBjZmI0OTMwMDAxMDAwMDEzIiwiY3JlYXRlZF9vbiI6MTM5NjQ2MTg2MCwic2lnbmF0dXJlIjoiUzdYV1h6d2VaNk5vZWZialoxeGFrQmNlQjM0VktEb0s1bytRTGZOckZyST0ifQ" }
        let(:request_params) { { "vestorly-auth" => authentication_token } }

        let(:success_response) {
          {
            code: 202,
            message: "Successfully logged out."
          }
        }

        subject { described_class }

        before do
          VCR.insert_cassette 'sign_out', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it 'records the fixture' do
          api_request_helper(subject, request_params)
        end

        it 'makes sign out request to api returns status code ok' do
          sign_out_api = described_class.new(authentication_token)
          sign_out_api.sign_out.should eq(success_response)
        end

        it 'makes sign out request with class method' do
          described_class.sign_out(authentication_token).should eq(success_response)
        end

      end

      describe 'with invalid token' do

        let(:authentication_token) { "invalidTokenSomething" }
        let(:request_params) { { "vestorly-auth" => authentication_token } }

        let(:error_response) {
          {
            code: 404,
            message: "Not signed in."
          }
        }

        subject { described_class }

        before do
          VCR.insert_cassette 'invalid_sign_out', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it 'records the fixture' do
          api_request_helper(subject, request_params)
        end

        it 'makes sign out request with class method' do
          described_class.sign_out(authentication_token).should eq(error_response)
        end

      end
    end
  end
end
