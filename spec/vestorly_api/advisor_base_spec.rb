require 'spec_helper'

describe VestorlyApi::AdvisorBase do

  def api_request_helper(requester, request_params)
    requester.get(
      requester.advisor_api_endpoint,
      query: request_params
    )
  end

  describe 'default attributes' do

    subject { described_class }

    it 'should include httparty methods' do
      subject.should include(HTTParty)
    end

    it 'gives the base uri api for advisors' do
      subject.advisor_api_endpoint.should eq('https://www.vestorly.com/api/v1/advisors')
    end

  end

  describe 'with valid parameters' do

    let(:username) { 'jpwisz@gmail.com' }
    let(:password) { '12desbrosses' }
    let(:advisor_id) { 'wisz' }

    let(:request_params) { {
      username: username,
      password: password
    }}

    let(:authentication_token) { "eyJwYXlsb2FkIjoiNGY2NTQyYzBjZmI0OTMwMDAxMDAwMDEzIiwiY3JlYXRlZF9vbiI6MTM5NjQ2MTg2MCwic2lnbmF0dXJlIjoiUzdYV1h6d2VaNk5vZWZialoxeGFrQmNlQjM0VktEb0s1bytRTGZOckZyST0ifQ" }

    before do
      VestorlyApi::SignIn.any_instance.stub(:sign_in).with(username, password).and_return { authentication_token }
      VestorlyApi::SignIn.any_instance.stub(:authentication_token).and_return { authentication_token }
      VestorlyApi::SignIn.any_instance.stub(:advisor_id).and_return { advisor_id }
      @sign_in_api = VestorlyApi::SignIn.new(username, password)
    end

    subject { described_class }

    it 'gives the api endpoints based action' do
      advisor_api = described_class.new(@sign_in_api)
      advisor_api.action_api_endpoint('some_action.json')
        .should eq("https://www.vestorly.com/api/v1/advisors/wisz/some_action.json")
    end

    describe 'advisor user entries' do

      before do
        VCR.insert_cassette 'advisor_user_entries', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it 'records the fixture' do
        advisor_api = described_class.new(@sign_in_api)
        advisor_api.advisor_user_entries({ 'filter_by' => 'prospects' })
      end

      it 'gives the advisor user entries' do
        advisor_api = described_class.new(@sign_in_api)
        response = advisor_api.advisor_user_entries({ 'filter_by' => 'prospects' })
        response.code.should eq(200)
      end

    end

    describe 'advisor csv upload' do
      before do
        VCR.insert_cassette 'advisor_csv_upload', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end
    end

    describe 'advisor advisor_posts' do

      before do
        VCR.insert_cassette 'advisor_posts', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it 'records the fixture' do
        advisor_api = described_class.new(@sign_in_api)
        advisor_api.advisor_posts
      end

      it 'gives the advisor user entries' do
        advisor_api = described_class.new(@sign_in_api)
        response = advisor_api.advisor_posts
        response.code.should eq(200)
      end

    end

  end

end
