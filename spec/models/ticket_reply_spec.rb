require 'rails_helper'

RSpec.describe TicketReply, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :description }
  end

  describe 'association' do
    it { is_expected.to belong_to :ticket }
    it { is_expected.to belong_to :user }
  end
end
