class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship

  validates :user, :ship, presence: true
  validates :date_start, :date_end, :crew_size, presence: true
  validate :end_after_start
  validates :crew_size, :total_amount, numericality: { only_integer: true }

  private

  def end_after_start
    if date_end < date_start
      errors.add(:date_end, "must be after the start date")
    end
  end
end
