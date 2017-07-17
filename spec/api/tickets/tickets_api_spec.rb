require 'rails_helper'

RSpec.describe Tickets::TicketsAPI do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:user) { FactoryGirl.create :user, user_type_id: user_type.id, username: 'asd', email: 'js@jk.com' }
  let(:ticket) { FactoryGirl.create :ticket, user_id: user.id }
  
  let(:valid_params) do
    {
      name: 'ABCD',
      email: 'x@y.com',
      subject: 'hello',
      message: 'How are you ?',
      status_type: 'open',
      user_id: user.id
    }
  end
  let(:invalid_params) do
    {
      name: nil,
      email: nil,
      subject: nil,
      message: nil,
      status_type: 'open',
      user_id: user.id
    }
  end

  let(:new_params) do
    {
      name: 'EFGH',
      email: 'x@y.com',
      subject: 'hello',
      message: 'I am fine',
      status_type: 'open',
      user_id: user.id
    }
  end
  describe 'GET #api/tickets' do
    it 'assigns all tickets as tickets' do
      get '/api/tickets'
      expect(response).to be_success
    end
  end

  describe 'GET #api/tickets/1' do
    context 'when ticket exist' do
      it 'assigns specific tickets as tickets' do
        get "/api/tickets/#{ ticket.id }"
        expect(response).to be_success
      end
    end

    context 'when ticket is not exist' do
      it 'returns 404' do
        get "/api/tickets/4242"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'DELETE #api/tickets/1' do
    context 'when ticket exist' do
      it 'assigns specific tickets as tickets' do
        delete "/api/tickets/#{ ticket.id }"
        expect(response).to be_success
      end
    end

    context 'when ticket is not exist' do
      it 'returns 404' do
        delete "/api/tickets/4242"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST #api/tickets' do
    let(:request_url) { '/api/tickets' }

    context 'valid params' do
      it "creates a ticket" do
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

  describe 'PUT #api/tickets' do
    let(:request_url) { "/api/tickets/#{ticket.id}" }

    context 'valid params' do
      it "updates a ticket" do
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
