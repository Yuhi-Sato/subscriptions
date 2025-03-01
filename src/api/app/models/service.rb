class Service < ApplicationRecord
  has_many :plans, dependent: :destroy

  validates :service_name, presence: true
  validates :category, presence: true
  validates :official_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "は有効なURLである必要があります" }
end
