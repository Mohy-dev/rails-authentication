class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  has_secure_password

  before_save :downcase_email

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}


  def confirm!
    update_columns(confirmed_at: Time.current)
  end

  def confirmed?
    confirm_at.present?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end

  def unconfirmed!
    !confirmed?
  end

  def down_case_email
    self.email = email.downcase
  end

end
