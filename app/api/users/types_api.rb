module Users
  class TypesAPI < Grape::API

    format :json

      desc 'User Type List', {
        :notes => <<-NOTE
        Get All User Type
         __________________
        NOTE
      }

      get do
        UserType.all
      end

      desc 'User Type by id', {
        :notes => <<-NOTE
        Get User Type By id
         __________________
        NOTE
      }

      params do
        requires :id, type: Integer, desc: 'User Type id'
      end

      get ':id' do
        begin
          user_type = UserType.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!({ status: :not_found }, 404)
        end
      end

      desc "Delete User Type By Id", {
        :notes => <<-NOTE
        Delete User Type By Id
         __________________
        NOTE
      }

      params do
        requires :id, type: Integer, desc: 'User Type id'
      end

      delete ':id' do
        begin
          user_type = UserType.find(params[:id])
          { status: :success } if user_type.delete
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end

      desc "Update User type By Id", {
        :notes => <<-NOTE
        Update User Type By Id
        __________________
        NOTE
      }

      params do
        requires :id, type: Integer, desc: "User Type id"
        requires :name, type: String, desc: "User Type name"
        optional :published, type: Boolean, desc: "User Type published"
      end

      put ':id' do
        begin
          user_type = UserType.find(params[:id])
          if user_type.update({
                                name: params[:name],
                                published: params[:published]


                              })

            { status: :success }
          else
            error!({ status: :error, message: user_type.errors.full_messages.first }) if user_type.errors.any?
          end

        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end

      desc "Create User Type", {
        :notes => <<-NOTE
        Create User Type
         __________________
        NOTE
      }

      params do
        requires :id, type: Integer, desc: "User Type id"
        requires :name, type: String, desc: "User Type name"
        optional :published, type: Boolean, desc: "User Type published"
      end

      post do
        begin
          user_type= UserType.create({
                                       name: params[:name],
                                       published: params[:published]
                                     })
          if user_type.save
            { status: :success }
          else
            error!({ status: :error, message: user_type.errors.full_messages.first }) if user_type.errors.any?
          end

        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end

    end
  end

