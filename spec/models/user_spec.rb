require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create :user, username: 'abc', email: 'demo@example.com', password: 'secret' }
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
end
