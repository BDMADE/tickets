require 'rails_helper'

RSpec.describe Users::UsersAPI do
  let!(:user_type) { FactoryGirl.create :user }
  let!(:user) { FactoryGirl.create :user, user_type_id: user_type.id, username: 'asd', email: 'js@jk.com' }
  
  let(:valid_params) do
    {
      name: "John Doe 007",
      username: "john_doe007",
      password: "secret",
      email: "j007@doe.com",
      ip_address: "127.0.0.1",
      published: true,
      profession: "Engineer",
      user_type_id: user_type.id
    }
  end

  let(:invalid_params) do
    {
      name: nil,
      username: nil,
      password: nil,
      email: 'j@doe.com',
      ip_address: '127.0.0.1',
      profession: 'Engineer',
      user_type_id: user_type.id,
      published: true
    }
  end

  let(:new_params) do
    {
      name: 'John Adam',
      username: 'john_doe',
      password: 'secret',
      email: 'j@doe.com',
      ip_address: '127.0.0.1',
      published: true,
      profession: 'Engineer',
      user_type_id: user_type.id
    }
  end
  describe 'GET #api/users' do
    it 'assigns all users as users' do
      get '/api/users'
      expect(response).to be_success
    end
  end

  describe 'GET #api/users/1' do
    context 'when user exist' do
      it 'assigns specific users as users' do
        get "/api/users/#{ user.id }"
        expect(response).to be_success
      end
    end

    context 'when user is not exist' do
      it 'returns 404' do
        get "/api/users/4242"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'DELETE #api/users/1' do
    context 'when user exist' do
      it 'assigns specific users as users' do
        delete "/api/users/#{ user.id }"
        expect(response).to be_success
      end
    end

    context 'when user is not exist' do
      it 'returns 404' do
        delete "/api/users/4242"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST #api/users' do
    let(:request_url) { '/api/users' }

    context 'valid params' do
      it "creates a user" do
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

  describe 'PUT #api/users' do
    let(:request_url) { "/api/users/#{user.id}" }

    context 'valid params' do
      it "updates a user" do
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