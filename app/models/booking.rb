class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship
  monetize :price_cents
  has_one :order
  validates :user, :ship, presence: true
  validates :date_start, :date_end, :crew_size, presence: true
  validate :end_after_start
  validates :crew_size, :total_amount, numericality: { only_integer: true }
  validates :status, inclusion: { in: %w(pending validated paid cancelled closed), message: "%{value} is not a valid status (pending, validated, paid, cancelled, closed are valid)" }

  private

  def end_after_start
    if date_end < date_start
      errors.add(:date_end, "must be after the start date")
    end
  end
end
