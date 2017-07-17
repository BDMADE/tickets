require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, name: 'John', user_type_id: user_type.id }
  # This should return the minimal set of attributes required to create a valid
  # Ticket. As you add validations to Ticket, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do {
    name: "Adam",
    email: "a@d.com",
    subject: "New Ticket",
    message: "Hi, hello",
    status_type: 'open',
    user_id: user.id
  }
  end

  let(:invalid_attributes) do {
      name: nil,
      email: nil,
      subject: nil,
      message: nil,
      status_type: nil,
      user_id: nil
  }
  end

  before :each do
    log_in_as user
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TicketsController. Be sure to keep this updated too.

  describe "GET #index" do
    it "returns a success response" do
      ticket = Ticket.create! valid_attributes
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      ticket = Ticket.create! valid_attributes
      get :show, params: { id: ticket.to_param }
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      ticket = Ticket.create! valid_attributes
      get :edit, params: {id: ticket.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a registration Ticket" do
        expect {
          post :create, params: { ticket: valid_attributes }
        }.to change(Ticket, :count).by(1)
      end

      it "redirects to the tickets" do
        post :create, params: {ticket: valid_attributes}
        expect(response).to redirect_to(welcome_path)
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        post :create, params: {ticket: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do {
        name: "Adam",
        email: "a@d.com",
        subject: "New Ticket",
        message: "Thnak You",
        status_type: 'closed',
        user_id: user.id
      }
      end

      it "updates the requested ticket" do
        ticket = Ticket.create! valid_attributes
        put :update, params: {id: ticket.to_param, ticket: new_attributes}
        ticket.reload
      end

      it "redirects to the tickets" do
        ticket = Ticket.create! valid_attributes
        put :update, params: {id: ticket.to_param, ticket: valid_attributes}
        expect(response).to redirect_to(tickets_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        ticket = Ticket.create! valid_attributes
        put :update, params: {id: ticket.to_param, ticket: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested ticket" do
      ticket = Ticket.create! valid_attributes
      expect {
        delete :destroy, params: {id: ticket.to_param}
      }.to change(Ticket, :count).by(-1)
    end

    it "redirects to the tickets list" do
      ticket = Ticket.create! valid_attributes
      delete :destroy, params: {id: ticket.to_param}
      expect(response).to redirect_to(tickets_url)
    end
  end

end
