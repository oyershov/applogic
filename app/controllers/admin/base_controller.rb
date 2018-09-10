module Admin
  class BaseController < ::ApplicationController
    layout 'admin'

    before_action :auth_admin!
    before_action :auth_user!

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end
  end
end