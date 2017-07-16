require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, user_type_id: user_type.id }
  
  before do
    log_in_as user
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
