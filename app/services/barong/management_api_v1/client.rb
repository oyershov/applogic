# frozen_string_literal: true

module Barong
  module ManagementAPIv1
    class Client < ::ManagementAPIv1::Client
      def initialize(*)
        super ENV.fetch('BARONG_ROOT_URL'), Rails.configuration.x.barong_management_api_v1_configuration
      end

      def otp_sign(request_params = {})
        self.action = :otp_sign
        params = request_params.slice(:account_uid, :otp_code, :jwt)
        request(:post, 'otp/sign', params)
      end

      def read_accounts(request_params = {})
        self.action = :read_accounts
        params = request_params.slice(:uid)
        request(:post, 'accounts/get', params)
      end

      def create_account(request_params = {})
        self.action = :write_accounts
        params = request_params.slice(:email, :password)
        request(:post, 'accounts', params)
      end

      def get_labels(request_params = {})
        self.action = :read_labels
        request(:post, 'labels/list', account_uid: request_params.fetch(:uid))
      end

      def update_label(request_params = {})
        self.action = :write_labels
        params = request_params.slice(:account_uid, :key, :value)
        request(:put, 'labels', params)
      end
      
      def create_label(request_params = {})
        self.action = :write_labels
        params = request_params.slice(:account_uid, :key, :value)
        request(:post, 'labels', params)
      end
    end
  end
end
