class User < ApplicationRecord
  has_one_attached :avatar
  validates :avatar, content_type: ['image/png', 'image/jpeg'],
            size: {less_than: 1.megabyte}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, length: {maximum: 255}
  validates :password, presence: true, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  has_secure_password
end
