require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user_type) { FactoryGirl.create :user_type }
  let(:user) { FactoryGirl.create :user, user_type_id: user_type.id, remember_token: 'zaqwscderfv' }

  describe '#log_in' do
    it 'checks login user' do
      expect(log_in(user)).to eq(user.id)
    end
  end

  describe '#remember' do
    it 'checks user remember token' do
      expect(remember(user)).to eq(user.remember_token)
    end
  end

  describe '#current_user' do
    context 'with session' do
      before do
        session[:user_id] = user.id
      end
      it 'checks user presence' do
        expect(current_user).to eq(user)
      end
    end

    context 'with cookies' do
      before do
        cookies.signed[:user_id] = user.id
        allow_any_instance_of(User).to receive(:authenticated?).and_return(true)
      end
      it 'checks user presence' do
        expect(current_user).to eq(user)
      end
    end
  end

  describe '#logged_in?' do
    before do
      allow_any_instance_of(UsersHelper).to receive(:current_user).and_return(user)
    end
    it 'checks user logged in status' do
      expect(logged_in?).to be true
    end
  end

  describe '#forget(user)' do
    it 'checks user forgot status' do
      expect(forget(user)).to be nil
    end
  end

  describe '#log_out' do
    before do
      allow_any_instance_of(UsersHelper).to receive(:forget).and_return(user)
      @current_user = nil
    end
    it 'checks user logged out status' do
      expect(log_out).to eq(@current_user)
    end
  end
end
