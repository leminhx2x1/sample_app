class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: {minimum: Settings.user.name.min_length,
                     maximum: Settings.user.name.max_length}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
  format: {with: VALID_EMAIL_REGEX}

  # Validate password
  validates :email, presence: true,
            length: {minimum: Settings.user.password.min_length,
                     maximum: Settings.user.password.max_length}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
