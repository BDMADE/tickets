require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, user_type_id: user_type.id }
  let(:ticket_1) { FactoryGirl.create :ticket, status_type: 'closed', user_id: user.id, created_at: 1.month.ago.beginning_of_month }
  let(:ticket_2) { FactoryGirl.create :ticket, status_type: 'closed', user_id: user.id }
  let(:ticket_3) { FactoryGirl.create :ticket, status_type: 'open', user_id: user.id }
  let(:ticket_4) { FactoryGirl.create :ticket, status_type: 'open', user_id: user.id }
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :message }
    it { is_expected.to validate_presence_of :subject }
  end

  describe 'association' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :ticket_replies }
  end

  describe '#closed_ticket' do
    it 'returns closed tickets' do
      expect(described_class.closed_ticket(user)).to eq([ticket_1, ticket_2])
    end
  end

  describe '#open_ticket' do
    it 'returns open tickets' do
      expect(described_class.open_ticket(user)).to eq([ticket_3, ticket_4])
    end
  end

  describe '#in_last_month'do
    it 'returns all last month closed tickets' do
      expect(described_class.in_last_month).to eq([ticket_1])
    end
  end
end
