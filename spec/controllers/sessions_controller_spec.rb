require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let!(:user) do
    FactoryGirl.create :user,
                       username: 'johndoe',
                       name: 'John',
                       email: 'john@doe.com',
                       user_type_id: user_type.id
  end
  let(:valid_attributes) do
    { username: 'johndoe',
      password: 'secret',
      remember_me: nil }
  end

  let(:invalid_attributes) do
    { username: 'johndoe',
      password: nil,
      remember_me: nil }
  end

  let(:valid_attributes_1) do
    { username: 'john@doe.com',
      password: 'secret',
      remember_me: nil }
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'valid params of using username' do
      it 'updates users ip address and re-direct to dashboard' do
        post :create, params: { session: valid_attributes }
        expect(response).to redirect_to(welcome_path)
      end

      it 'shows logged in message' do
        post :create, params: { session: valid_attributes }
        expect(flash[:notice]).to match(/Logged in !/)
      end
    end

    context 'valid params of using email' do
      it 're-direct to dashboard' do
        post :create, params: { session: valid_attributes_1 }
        expect(response).to redirect_to(welcome_path)
      end

      it 'shows success logged in message' do
        post :create, params: { session: valid_attributes_1 }
        expect(flash[:notice]).to match(/Logged in !/)
      end
    end

    context 'invalid params' do
      it 're-direct to login path' do
        post :create, params: { session: invalid_attributes }
        expect(response).to redirect_to(login_path)
      end

      it 'shows success logged in message' do
        post :create, params: { session: invalid_attributes }
        expect(flash[:alert]).to match(/Invalid data combination ! Please log in again/)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      log_in_as user
    end

    it 're-direct to login path' do
      get :destroy
      expect(response).to redirect_to(login_path)
    end

    it 'shows logout message' do
      get :destroy
      expect(flash[:notice]).to match(/Logged out !/)
    end
  end
end
