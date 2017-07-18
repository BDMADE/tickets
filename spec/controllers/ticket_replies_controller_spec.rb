require 'rails_helper'

RSpec.describe TicketRepliesController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, name: 'John', user_type_id: user_type.id }
  let(:ticket) { FactoryGirl.create :ticket, user_id: user.id }
  # This should return the minimal set of attributes required to create a valid
  # Ticket. As you add validations to Ticket, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do {
    description: 'It is first reply',
    user_id: user.id,
    ticket_id: ticket.id
  }
  end

  before :each do
    log_in_as user
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a registration Ticket" do
        #get :show, ticket_id: ticket.id
        expect {
          post :create, params: { ticket_id: ticket.id, ticket_reply: valid_attributes }
        }.to change(TicketReply, :count).by(1)
      end

      it "redirects to the tickets" do
        post :create, params: { ticket_id: ticket.id, ticket_reply: valid_attributes }
        expect(response).to redirect_to(ticket_path(ticket.id))
      end
    end
  end
end
