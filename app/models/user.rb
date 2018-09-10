# frozen_string_literal: true

class User < ApplicationRecord
  with_options(class_name: 'User') do |o|
    o.belongs_to :referrer,
                 optional: true
    o.has_many   :affiliates,
                 foreign_key: :referrer_id
  end

  serialize :options, JSON

  before_validation :assign_fererral_code

  validates_lengths_from_database
  validates :email, email: true, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :level, numericality: { greater_than_or_equal_to: 0 }
  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  validates :referral_code, presence: true, uniqueness: { case_sensitive: false }

  attr_readonly :uid, :email, :referral_code

  scope :enabled, -> { where(state: 'active') }
  scope :disabled, -> { where.not.enabled }

  def assign_fererral_code
    return if referral_code.present?
    loop do
      self.referral_code = ReferralProgram::GenerateCode.call
      break unless User.exists?(referral_code: referral_code)
    end
  end

  def email=(value)
    super value.try(:downcase)
  end

  def uid=(value)
    super value.try(:upcase)
  end

  def state
    super.inquiry
  end

  def disabled?
    state != 'active'
  end

  def admin?
    options.fetch('labels', {}).any? do |l|
      l['scope'] == 'private' &&
        l['key'] == 'applogic_admin' &&
        l['value'] == 'true'
    end
  end
end
