class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship

  validates :user_id, :ship_id, presence: true, numericality: { only_integer: true }
end
