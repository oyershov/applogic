# frozen_string_literal: true

module APIv1
  module Entities
    class User < Grape::Entity
      format_with(:iso_timestamp) { |d| d.utc.iso8601 }

      expose :uid, documentation: { type: 'String' }
      expose :email, documentation: { type: 'String' }
      expose :level, documentation: { type: 'Integer' }
      expose :state, documentation: { type: 'String' }
      expose :custom_withdrawal_limit, documentation: { type: 'Integer' }
      expose :referrer_id, documentation: { type: 'Integer' }
      expose :referral_code, documentation: { type: 'String' }
      expose :options, documentation: { type: 'String' }

      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end
