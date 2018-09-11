# frozen_string_literal: true

module APIv1
  class CreateUser < Grape::API
    resource :users do
      desc 'Creates new user',
           success: { code: 201, message: 'New user created' },
           failure: [
             { code: 400, message: 'Required params are missing' },
             { code: 422, message: 'Validation errors' }
           ]
      params do
        requires :email,         type: String, desc: 'User Email',    allow_blank: false
        requires :password,      type: String, desc: 'User Password', allow_blank: false
        optional :referral_code, type: String, desc: 'Referral Code', allow_blank: true
      end
      post do
        user_attributes = Barong::ManagementAPIv1::Client.new.create_account(
          email:    params[:email],
          password: params[:password]
        )
        user = User.create(user_attributes)
        error!(user.errors.full_messages, 422) if user.new_record?

        if params[:referral_code].present?
          referrer = User.find_by(referral_code: params[:referral_code])
          referrer.affiliates << user if referrer.present?
        end

        user
      end
    end
  end
end
