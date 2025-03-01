class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :subscriptions, dependent: :destroy
end
