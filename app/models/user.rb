class User < ApplicationRecord
  extend ActiveModel::Callbacks

  after_create do
    self.create_wall
  end

  has_many :microposts, dependent: :destroy
  has_one :wall, dependent: :destroy
  has_one_attached :avatar

  attr_accessor :remember_token

  validates :avatar, content_type: ['image/png', 'image/jpeg'],
            size: {less_than: 1.megabyte}
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, length: {maximum: 255}
  validates :password, presence: true, confirmation: true, length: {minimum: 6}, allow_nil: true
  validates :password_confirmation, presence: true, allow_blank: true

  before_save { self.email = email.downcase }

  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
