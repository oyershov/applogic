# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::Helpers
  include ActionController::Flash

  protect_from_forgery with: :exception
  extend Memoist

  def current_user
    return if session[:uid].blank?

    User.enabled.find_by(uid: session[:uid])
  end
  memoize :current_user
  helper_method :current_user

  def auth_user!
    return if current_user

    redirect_to root_path, alert: t('activations.new.login_required')
  end

  def auth_anybody!
    redirect_to root_path if current_user
  end

  def auth_admin!
    redirect_to root_path unless admin?
  end

  def admin?
    return false unless current_user

    current_user.admin?
  end
  helper_method :admin?
end
