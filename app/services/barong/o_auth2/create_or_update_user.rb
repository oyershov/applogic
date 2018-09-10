# frozen_string_literal: true

module Barong
  module OAuth2
    class CreateOrUpdateUser
      def call(auth_hash)
        uid = auth_hash.fetch('uid')

        user = User.find_by(uid: uid) || User.new
        user.tap do |u|
          u.uid     = uid
          info_hash = auth_hash.fetch('info')
          u.level   = info_hash['level'] if info_hash.key?('level')
          u.state   = info_hash['state'] if info_hash.key?('state')
          u.email   = info_hash.fetch('email')
          u.options[:labels] =
            Barong::ManagementAPIv1::Client.new.get_labels(uid: uid)
          u.save!
        end
      rescue => e
        report_exception(e)
        Rails.logger.debug { "OmniAuth data: #{auth_hash.to_json}." }
        Rails.logger.debug { "Member: #{user.to_json}." } if user.present?
        raise e
      end
    end
  end
end
