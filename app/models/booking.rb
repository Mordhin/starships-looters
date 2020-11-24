class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship

  validates :user, :ship, presence: true
  validates :date_start, :date_end, presence: true, if: -> {:date_start < :date_end} 
  validates :crew_size, :date_start, :date_end, numericality: { only_integer: true }
end
