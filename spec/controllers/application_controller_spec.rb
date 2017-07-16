require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let!(:user_type) { FactoryGirl.create :user_type }
  let(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:restricted_permission) { FactoryGirl.create :permission,
                                                   user_type_id: user_type.id,
                                                   dashboard: false,
                                                   edit: false,
                                                   add: false,
                                                   remove_ability: false }
  let!(:user) { FactoryGirl.create :user, name: 'Tanbir', user_type_id: user_type.id }

  before :each do
    log_in_as user
  end

  describe '#has_permission?' do
    context 'super admin facility' do
      before do
        permission.save
      end
      it 'checks user permission for dashboard' do
        expect(subject.has_permission?('dashboard')).to be true
      end


      it 'checks user permission for usertype' do
        expect(subject.has_permission?('usertype')).to be true
      end

      it 'checks user permission for user' do
        expect(subject.has_permission?('user')).to be true
      end
    end


    context 'restricted facility' do
      before do
        restricted_permission.save
      end

      it 'does not allow to in dashboard' do
        expect(subject.has_permission?('dashboard')).to be false
      end
    end
  end

  describe '#can_edit?' do
    context 'super admin facility' do
      before do
        permission.save
      end

      it 'checks user permission for edit' do
        expect(subject.has_permission?('edit')).to be true
      end

    end

    context 'restricted facility' do
      before do
        restricted_permission.save
      end

      it 'does not allow to edit' do
        expect(subject.has_permission?('edit')).to be false
      end
    end
  end

  describe '#can_add?' do
    context 'super admin facility' do
      before do
        permission.save
      end

      it 'checks user permission for add' do
        expect(subject.has_permission?('add')).to be true
      end
    end

    context 'restricted facility' do
      before do
        restricted_permission.save
      end

      it 'does not allow to add' do
        expect(subject.has_permission?('add')).to be false
      end
    end
  end

  describe '#can_delete?' do

    context 'super admin facility' do
      before do
        permission.save
      end

      it 'checks user permission for delete' do
        expect(subject.has_permission?('remove_ability')).to be true
      end
    end

    context 'restricted facility' do
      before do
        restricted_permission.save
      end

      it 'does not allow to delete' do
        expect(subject.has_permission?('remove_ability')).to be false
      end
    end
  end
end
