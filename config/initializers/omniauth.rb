# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  case ENV['OAUTH2_SIGN_IN_PROVIDER']
  when 'barong'
    require 'omniauth-barong'
    provider :barong,
             ENV.fetch('OAUTH2_BARONG_CLIENT_ID'),
             ENV.fetch('OAUTH2_BARONG_CLIENT_SECRET'),
             domain: ENV.fetch('OAUTH2_BARONG_DOMAIN')
  end
end

OmniAuth.config.on_failure = lambda do |env|
  SessionsController.action(:failure).call(env)
end

OmniAuth.config.logger = Rails.logger
