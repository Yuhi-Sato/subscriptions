class Plan < ApplicationRecord
  belongs_to :service
  has_many :subscriptions, dependent: :destroy

  validates :plan_name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true
  validates :billing_cycle, presence: true, inclusion: { in: %w(monthly yearly), message: "は monthly または yearly である必要があります" }
end
