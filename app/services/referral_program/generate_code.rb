# frozen_string_literal: true

require 'securerandom'

module ReferralProgram
  class GenerateCode
    def self.call
      SecureRandom.hex(5)
    end
  end
end
