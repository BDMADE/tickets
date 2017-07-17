module Users
  class UsersAPI < Grape::API

    format :json

    desc 'User Lists', {
      :notes => <<-NOTE
        Get All Users
         __________________
      NOTE
    }

    get do
      User.all
    end

    desc 'User by id', {
      :notes => <<-NOTE
        Get User By id
         __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: 'User id'
    end

    get ':id' do
      begin
        user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        error!({ status: :not_found }, 404)
      end
    end

    desc "Delete User By Id", {
      :notes => <<-NOTE
        Delete User By Id
         __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: 'User id'
    end

    delete ':id' do
      begin
        user = User.find(params[:id])
        { status: :success } if user.delete
      rescue ActiveRecord::RecordNotFound
        error!({ status: :error, message: :not_found }, 404)
      end
    end

    desc "Update User By Id", {
      :notes => <<-NOTE
        Update User By Id
        __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: "User id"
      requires :name, type: String, desc: "User name"
      requires :email, type: String, desc: "User email"
      requires :password, type: String, desc: "User password"
      optional :ip_address, type: String, desc: "User ip address"
      optional :profession, type: String, desc: "User profession"
      optional :phone, type: String, desc: "User phone"
      optional :user_type_id, type: Integer, desc: "User name"
      optional :published, type: Boolean, desc: "User published"
    end

    put ':id' do
      begin
        user = User.find(params[:id])
        if user.update({
                         name: params[:name],
                         email: params[:email],
                         password: params[:password],
                         ip_address: params[:ip_address],
                         profession: params[:profession],
                         phone: params[:phone],
                         user_type_id: params[:user_type_id],
                         published: params[:published]
                       })

          { status: :success }
        else
          error!({ status: :error, message: user.errors.full_messages.first }) if user.errors.any?
        end

      rescue ActiveRecord::RecordNotFound
        error!({ status: :error, message: :not_found }, 404)
      end
    end

    desc "Create User", {
      :notes => <<-NOTE
        Create User
         __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: "User id"
      requires :name, type: String, desc: "User name"
      requires :email, type: String, desc: "User email"
      requires :password, type: String, desc: "User password"
      optional :ip_address, type: String, desc: "User ip address"
      optional :profession, type: String, desc: "User profession"
      optional :phone, type: String, desc: "User phone"
      optional :user_type_id, type: Integer, desc: "User name"
      optional :published, type: Boolean, desc: "User published"
    end

    post do
      begin
        user = User.create({
                             name: params[:name],
                             email: params[:email],
                             password: params[:password],
                             ip_address: params[:ip_address],
                             profession: params[:profession],
                             phone: params[:phone],
                             user_type_id: params[:user_type_id],
                             published: params[:published]
                           })
        if user.save
          { status: :success }
        else
          error!({ status: :error, message: user.errors.full_messages.first }) if user.errors.any?
        end

      rescue ActiveRecord::RecordNotFound
        error!({ status: :error, message: :not_found }, 404)
      end
    end

  end
end
