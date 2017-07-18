require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let(:agent_user_type) { FactoryGirl.create :user_type, name: 'agent' }
  let(:client_user_type) { FactoryGirl.create :user_type, name: 'customer' }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:admin_user) { FactoryGirl.create :user, user_type_id: user_type.id, username: 'admin007', email: 'admin@ex.com' }
  let!(:agent_user) { FactoryGirl.create :user, user_type_id: agent_user_type.id, username: 'agent007', email: 'agent@ex.com' }
  let!(:client_user) { FactoryGirl.create :user, username: 'client007', email: 'client@ex.com', user_type_id: client_user_type.id }

  before do
    log_in_as admin_user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #welcome" do
    it "returns http success" do
      get :welcome
      expect(response).to have_http_status(:success)
    end
  end

end
