class PlanSerializer < ActiveModel::Serializer
  attributes :id, :plan_name, :price, :currency, :billing_cycle, :created_at, :updated_at

  belongs_to :service
  has_many :subscriptions
end
