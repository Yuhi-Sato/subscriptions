class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :service_name, :category, :official_url, :created_at, :updated_at

  has_many :plans
end
