require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_type) { FactoryGirl.create :user_type }
  let!(:permission) { FactoryGirl.create :permission, user_type_id: user_type.id }
  let(:user) { FactoryGirl.create :user, name: 'John', user_type_id: user_type.id }

  before :each do
    log_in_as user
  end

  let(:valid_attributes) do {
    name: 'John Doe',
    username: 'john_doe',
    password: 'secret',
    email: 'j@doe.com',
    ip_address: '127.0.0.1',
    published: true,
    profession: 'Engineer',
    user_type_id: user_type.id
  }
  end
  let(:invalid_attributes) do {
    name: nil,
    username: nil,
    password: nil,
    email: nil,
    ip_address: nil,
    pin_number: nil,
    published: false,
    profession: nil,

  }
  end

  describe 'GET #index' do
    it 'assigns all users as @users' do
      user = User.create! valid_attributes
      get :index
      expect(assigns(:users)).to include(user)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, params: { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #registration' do
    it 'assigns a registration user as @user' do
      FactoryGirl.create :user_type, name: 'customer'
      get :registration
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :edit, params: {id: user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a registration User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, params: {user: valid_attributes}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, params: {user: valid_attributes}
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, params: {user: invalid_attributes}
        expect(assigns(:user)).to be_a_new(User)
      end

      it 're-renders the registration template' do
        post :create, params: {user: invalid_attributes}
        expect(response).to redirect_to(registrations_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do {
        name: 'Allen',
        username: 'allen',
        password: 'secret',
        remember_digest: 'rem007',
        email: 'a@d.com',
        ip_address: '127.0.0.1',
        published: true,
        profession: 'Engineer',
      }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: new_attributes}
        user.reload
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: invalid_attributes}
        expect(assigns(:user)).to eq(user)
      end

      it 're-renders the edit template' do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete :destroy, params: {id: user.to_param}
      expect(response).to redirect_to(users_url)
    end
  end

end
