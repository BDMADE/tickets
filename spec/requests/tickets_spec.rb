require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, user_type_id: user_type.id }

  before do
    sign_in_as user
  end

  describe "GET /tickets" do
    it "works! (now write some real specs)" do
      get tickets_path
      expect(response).to have_http_status(200)
    end
  end
end
