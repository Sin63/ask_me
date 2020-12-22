require 'openssl'

# Модель пользователя.
class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  USER_REGEX = /\A\w+\z/

  attr_accessor :password

  # has_many :questions, dependent: :destroy
  has_many :questions, dependent: :delete_all
  before_validation :username_downcase, :email_downcase
  before_save :encrypt_password

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: { maximum: 40 }, format: { with: USER_REGEX }
  validates :email, format: { with: EMAIL_REGEX }
  validates :password, confirmation: true, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)
    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password
    nil
  end

  private
  
  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def username_downcase
    username&.downcase!
  end

  def email_downcase
    email&.downcase!
  end
end
