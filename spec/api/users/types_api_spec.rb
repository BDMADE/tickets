require 'rails_helper'

RSpec.describe Tickets::TicketsAPI do
  let!(:user_type) { FactoryGirl.create :user_type }
  let!(:user) { FactoryGirl.create :user, user_type_id: user_type.id, username: 'asd', email: 'js@jk.com' }

  let(:valid_params) do
    {
    name: 'Superadmin',
    published: true
    }
  end

  let(:invalid_params) do
    {
      name: nil,
      published: true
    }
  end

  let(:new_params) do
    {
    name: 'Manager',
    publsihed: true
    }
  end
  describe 'GET #api/user_types' do
    it 'assigns all user types as user_types' do
      get '/api/user_types'
      expect(response).to be_success
    end
  end

  describe 'GET #api/user_types/1' do
    context 'when user type exist' do
      it 'assigns specific user types as user_types' do
        get "/api/user_types/#{ user_type.id }"
        expect(response).to be_success
      end
    end

    context 'when user type is not exist' do
      it 'returns 404' do
        get "/api/user_types/4242"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'DELETE #api/user_types/1' do
    context 'when user type exist' do
      it 'assigns specific user types as user_types' do
        delete "/api/user_types/#{ user_type.id }"
        expect(response).to be_success
      end
    end

    context 'when user type is not exist' do
      it 'returns 404' do
        delete "/api/user_types/4242"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST #api/user_types' do
    let(:request_url) { '/api/user_types' }

    context 'valid params' do
      it "creates a user type" do
        post request_url, params: valid_params
        expect(response.status).to eq(201)
      end
    end

    context 'invalid params' do
      it "returns error" do
        post request_url, params: invalid_params
        expect(response.status).to eq(500)
      end
    end
  end

  describe 'PUT #api/user_types' do
    let(:request_url) { "/api/user_types/#{user_type.id}" }

    context 'valid params' do
      it "updates a user type" do
        put request_url, params: new_params
        expect(response.status).to eq(200)
      end
    end

    context 'invalid params' do
      it "returns error" do
        put request_url, params: invalid_params
        expect(response.status).to eq(500)
      end
    end
  end
end
