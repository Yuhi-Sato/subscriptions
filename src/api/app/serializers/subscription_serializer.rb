class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :end_at, :next_payment_date, :memo, :created_at, :updated_at

  belongs_to :user
  belongs_to :plan
end
