require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#full_title' do
    context 'when title is not nil' do
      let(:title) { 'Management' }
      it 'shows full title' do
        expect(full_title(title)).to eq('Tickets | Management')
      end
    end
    context 'when title is nil' do
      let(:title) { nil }
      it 'shows full title' do
        expect(full_title(title)).to eq('Tickets')
      end
    end
  end
end
