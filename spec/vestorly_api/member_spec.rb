require 'spec_helper'


describe VestorlyApi::Member do

  def api_request_helper(requester, end_point, request_params)
    requester.get(
      end_point,
      query: request_params
    )
  end

  let(:username) { 'testemail@vestorly.com' }
  let(:password) { 'testpassword' }
  let(:advisor_id) { 'rodas' }

  let(:request_params) { {
    username: username,
    password: password
  }}

  let(:authentication_token) { "testuathtokenapi" }

  before do
    VestorlyApi::SignIn.any_instance.stub(:sign_in).with(username, password).and_return { authentication_token }
    VestorlyApi::SignIn.any_instance.stub(:authentication_token).and_return { authentication_token }
    VestorlyApi::SignIn.any_instance.stub(:advisor_id).and_return { advisor_id }
    @sign_in_api = VestorlyApi::SignIn.new(username, password)
  end

  describe 'default attributes' do

    subject { described_class }

    it 'should include httparty methods' do
      subject.should include(HTTParty)
    end

  end

  describe 'fetch members' do

    describe 'with valid parameters' do

      before do
        VCR.insert_cassette 'fetch_members', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it 'records the fixture' do
        members_api = described_class.new(@sign_in_api)
        members_api.fetch({ 'filter_by' => 'prospects' })
      end

      it 'fetch members' do
        members_api = described_class.new(@sign_in_api)
        fetched_members = members_api.fetch({ 'filter_by' => 'prospects' })
        fetched_members.size.should eq(34)
      end

      it 'fetch members have requested fields' do
        members_api = described_class.new(@sign_in_api)
        fetched_members = members_api.fetch({ 'filter_by' => 'prospects' })
        fetched_members[0]['_id'].should eq('53a4c1acfc4674b330000019')
      end

    end

    describe 'with invalid token' do

      let(:authentication_token) { "invalid" }

      before do
        VCR.insert_cassette 'invalid_fetch_members', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it 'fetch raise exception' do
        members_api = described_class.new(@sign_in_api)
        expect { members_api.fetch }.to raise_error( VestorlyApi::Exceptions::Error )
      end
    end

  end

end
