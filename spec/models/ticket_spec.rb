require 'rails_helper'

RSpec.describe Ticket, type: :model do
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
end
