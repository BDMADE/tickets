require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_type) { FactoryGirl.create :user_type }
  let(:user_type_agent) { FactoryGirl.create :user_type, name: 'agent' }
  let(:user_type_customer) { FactoryGirl.create :user_type, name: 'customer' }
  let!(:user) { FactoryGirl.create :user, username: 'abc', email: 'demo@example.com', password: 'secret', user_type_id: user_type.id }
  let!(:agent_user) { FactoryGirl.create :user, username: 'deg', email: 'agent@example.com', password: 'secret', user_type_id: user_type_agent.id }
  let!(:customer_user) { FactoryGirl.create :user, username: 'fgh', email: 'customer@example.com', password: 'secret', user_type_id: user_type_customer.id }
  invalid_logins = ['b lah','bälah','b@lah','bülah','bßlah','b!lah','b%lah','b)lah']

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of :username }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_secure_password }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:username).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(255) }

  invalid_logins.each do |email|
    it { should_not allow_value(email).for(:email) }
  end

  describe '#agents_count' do
    it 'returns total number of agents' do
      expect(described_class.agents_count).to eq(1)
    end
  end

  describe '#agents_count' do
    it 'returns total number of customers' do
      expect(described_class.customers_count).to eq(1)
    end
  end

end
