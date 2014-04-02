require 'spec_helper'

describe VestorlyApi::Login do

  def api_request_helper(requester, request_params)
    requester.post(
      requester.login_api_endpoint,
      query: request_params
    )
  end

  describe 'default attributes' do

    subject { described_class }

    it 'should include httparty methods' do
      subject.should include(HTTParty)
    end

    it 'should have the base url set to the VestorlyApi API endpoint' do
      subject.login_api_endpoint.should eq('https://www.vestorly.com/api/v1/session_management/sign_in?version=1')
    end
  end

  describe 'login api' do
    describe "POST login" do

      describe "with valid authentication" do

        let(:username) { 'jpwisz@gmail.com' }
        let(:password) { '12desbrosses' }

        let(:request_params) { {
          username: username,
          password: password
        }}

        subject { described_class }

        before do
          VCR.insert_cassette 'login', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it 'records the fixture' do
          api_request_helper(subject, request_params)
        end

        it 'makes login request to api returns authentication token' do
          login_api = described_class.new(username, password)
          login_api.login.should eq("eyJwYXlsb2FkIjoiNGY2NTQyYzBjZmI0OTMwMDAxMDAwMDEzIiwiY3JlYXRlZF9vbiI6MTM5NjQ2MTg2MCwic2lnbmF0dXJlIjoiUzdYV1h6d2VaNk5vZWZialoxeGFrQmNlQjM0VktEb0s1bytRTGZOckZyST0ifQ")
        end

        it 'assigns api response for further use' do
          login_api = described_class.new(username, password)
          login_api.login
          login_api.instance_variable_get('@login_response').should_not be_nil
        end

        it 'gives authentication token after login' do
          login_api = described_class.new(username, password)
          login_api.login
          login_api.authentication_token.should eq("eyJwYXlsb2FkIjoiNGY2NTQyYzBjZmI0OTMwMDAxMDAwMDEzIiwiY3JlYXRlZF9vbiI6MTM5NjQ2MTg2MCwic2lnbmF0dXJlIjoiUzdYV1h6d2VaNk5vZWZialoxeGFrQmNlQjM0VktEb0s1bytRTGZOckZyST0ifQ")
        end

        it 'gives the advisor id' do
          login_api = described_class.new(username, password)
          login_api.login
          login_api.advisor_id.should eq("wisz")
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
          VCR.insert_cassette 'invalid_login', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it 'records the fixture' do
          api_request_helper(subject, request_params)
        end

        it 'raise unauthorized login error' do
          login_api = described_class.new(username, password)
          expect { login_api.login }.to raise_error( VestorlyApi::Exceptions::InvalidLoginCredentials )
        end

      end

    end
  end
end
