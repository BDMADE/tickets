require 'rails_helper'

RSpec.describe PasswordChangesController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let(:user) { FactoryGirl.create :user, user_type_id: user_type.id }

  before :each do
    log_in_as user
  end

  let(:valid_attributes) do
    { old_password: 'secret',
      password: '123123',
      password_confirmation: '123123' }
  end

  let(:invalid_attributes) do
    { old_password: '123123',
      password: 'secret',
      password_confirmation: 'secret' }
  end

  let(:invalid_attributes_1) do
    { old_password: 'secret',
      password: '123123',
      password_confirmation: '456456' }
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Post #update' do
    context 'valid params' do
      it 'updates users password and re-direct to dashboard' do
        post :update, params: { password_changes: valid_attributes }
        expect(response).to redirect_to(welcome_path)
      end

      it 'shows success flash message' do
        post :update, params: { password_changes: valid_attributes }
        expect(flash[:notice]).to match(/Password changed successfully!/)
      end
    end

    context 'invalid params of current password' do
      it 'redirects to password changes pages' do
        post :update, params: { password_changes: invalid_attributes }
        expect(response).to redirect_to(password_changes_path)
      end

      it 'shows alert flash message' do
        post :update, params: { password_changes: invalid_attributes }
        expect(flash[:alert]).to match(/You have entered invalid current paasword !/)
      end
    end

    context 'invalid params of password confirmation' do
      it 'redirects to password changes pages' do
        post :update, params: { password_changes: invalid_attributes_1 }
        expect(response).to redirect_to(password_changes_path)
      end

      it 'shows alert flash message' do
        post :update, params: { password_changes: invalid_attributes_1 }
        expect(flash[:alert]).to match(/Your password confirmation is failed !/)
      end
    end
  end
end
