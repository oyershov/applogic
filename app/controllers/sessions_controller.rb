# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :auth_user!, only: :destroy
  before_action :auth_anybody!, only: :failure

  def create
    self.user = Barong::OAuth2::CreateOrUpdateUser.new.call(auth_hash)

    return failure if user.blank?

    if user.disabled?
      return redirect_to(root_path,
                         alert: 'Your account has been disabled, contact admin if you have any problem.')
    end

    reset_session rescue nil
    session[:uid] = user.uid
    redirect_on_successful_sign_in
  end

  def failure
    redirect_to root_path,
                alert: 'Wrong user ID or password, please try again.'
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  attr_accessor :user

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end

  def redirect_on_successful_sign_in
    "OAUTH2_#{params[:provider].to_s.gsub(/(?:_|oauth2)+\z/i, '').upcase}_REDIRECT_URL".tap do |key|
      if ENV[key] && params[:provider].to_s == 'barong'
        redirect_to "#{ENV[key]}?#{auth_hash.fetch('credentials').to_query}"
      elsif ENV[key]
        redirect_to ENV[key]
      else
        redirect_to root_url
      end
    end
  end
end
