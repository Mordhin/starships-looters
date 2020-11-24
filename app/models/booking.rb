class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship

  validates :user, :ship, presence: true
  validates :date_start, :date_end, presence: true
  validates :end_after_start
  validates :crew_size, :date_start, :date_end, numericality: { only_integer: true }

  private

  def end_after_start
    return if end_date.blank? || date_start.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
