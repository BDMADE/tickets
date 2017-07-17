require 'rails_helper'

RSpec.describe UserTypesController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, user_type_id: user_type.id }

  before do
    log_in_as user
  end

  let(:valid_attributes) do{
    name: 'Admin',
    published: true
  }
  end
  let(:invalid_attributes) do{
    name: nil,
    published: false
  }
  end

  describe 'GET #index' do
    it 'assigns all user types as user_types' do
      user_type = UserType.create! valid_attributes
      get :index
      expect(assigns(:user_types)).to include(user_type)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user type' do
      user_type = UserType.create! valid_attributes
      get :show, params: {id: user_type.to_param}
      expect(assigns(:user_type)).to eq(user_type)
    end
  end

  describe 'GET #registration' do
    it 'assigns a registration user type as user_type' do
      get :registration
      expect(assigns(:user_type)).to be_a_new(UserType)
    end
  end

  describe 'GET #edit' do
    it 'assigns requested user type as user_type' do
      user_type = UserType.create! valid_attributes
      get :edit, params: {id: user_type.to_param}
      expect(assigns(:user_type)).to eq(user_type)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a registration UserType' do
        expect {
          post :create, params: {user_type: valid_attributes}
        }.to change(UserType, :count).by(1)
      end

      it 'assigns a newly created user_type as @user_type' do
        post :create, params: {user_type: valid_attributes}
        expect(assigns(:user_type)).to be_a(UserType)
        expect(assigns(:user_type)).to be_persisted
      end

      it 'redirects to the created user_type' do
        post :create, params: {user_type: valid_attributes}
        expect(response).to redirect_to(UserType.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user type' do
        post :create, params: {user_type: invalid_attributes}
        expect(assigns(:user_type)).to be_a_new(UserType)
      end

      it "re-renders the 'registration' template" do
        post :create, params: {user_type: invalid_attributes}
        expect(response).to render_template('registration')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do {
        name: 'Manager',
        publsihed: true
      }
      end

      it 'updates the requested user_type' do
        user_type = UserType.create! valid_attributes
        put :update, params: {id: user_type.to_param, user_type: new_attributes}
        user_type.reload
      end

      it 'assigns the requested user_type' do
        user_type = UserType.create! valid_attributes
        put :update, params: {id: user_type.to_param, user_type: valid_attributes}
        expect(assigns(:user_type)).to eq(user_type)
      end

      it 'redirects to the user_type' do
        user_type = UserType.create! valid_attributes
        put :update, params: {id: user_type.to_param, user_type: valid_attributes}
        expect(response).to redirect_to(user_type)
      end
    end

    context 'with invalid params' do
      it 'assigns the user_type' do
        user_type = UserType.create! valid_attributes
        put :update, params: {id: user_type.to_param, user_type: invalid_attributes}
        expect(assigns(:user_type)).to eq(user_type)
      end

      it 're-renders the edit template' do
        user_type = UserType.create! valid_attributes
        put :update, params: {id: user_type.to_param, user_type: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user_type' do
      user_type = UserType.create! valid_attributes
      expect {
        delete :destroy, params: {id: user_type.to_param}
      }.to change(UserType, :count).by(-1)
    end

    it 'redirects to the user_types list' do
      user_type = UserType.create! valid_attributes
      delete :destroy, params: {id: user_type.to_param}
      expect(response).to redirect_to(user_types_url)
    end
  end

end
