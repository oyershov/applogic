# frozen_string_literal: true

module APIv1
  class Users < Grape::API
    before { authenticate! }

    resource :users do
      desc 'Return a user by UID.',
           failure: [
             { code: 400, message: 'Required params are empty' },
             { code: 401, message: 'Invalid bearer token' },
             { code: 404, message: 'Record is not found' }
           ]
      params do
        requires :uid, type: String, allow_blank: false, desc: 'User UID.'
      end
      route_param :uid do
        get do
          user = User.find_by!(uid: params[:uid])
          present user, with: Entities::User
        end
      end
    end
  end
end
