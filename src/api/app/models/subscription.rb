class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :start_at, presence: true
  validates :next_payment_date, presence: true

  validate :end_date_after_start_date, if: -> { start_at.present? && end_at.present? }

  private

  def end_date_after_start_date
    if end_at <= start_at
      errors.add(:end_at, "は開始日より後の日付である必要があります")
    end
  end
end
